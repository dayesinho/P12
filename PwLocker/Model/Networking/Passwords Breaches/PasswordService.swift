//
//  PasswordService.swift
//  PwLocker
//
//  Created by Tavares on 30/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

class PasswordService {
    
    public enum ErrorCode: Error {
       
        case badRequest
        case forbidden
        case notFound
        case notAcceptable
        case tooManyRequests(_ retryInSeconds: Int)
    }
    
        private var task: URLSessionDataTask?
        private var passwordSession: URLSession
        fileprivate let apiPassword: String = "https://api.pwnedpasswords.com/range/"
    
        init(passwordSession: URLSession = URLSession(configuration: .default)) {
            self.passwordSession = passwordSession
        }
    
    fileprivate func generateRequest(with url: URL) -> URLRequest {
        let request = URLRequest(url: url)
        return request
    }
    
    fileprivate func sendRequest<T>(_ request: URLRequest, parseResult parseResultHandler: @escaping (Data) throws -> T, completion completionHandler: @escaping (() throws -> T) -> Swift.Void) -> URLSessionTask {
        
        let task = self.passwordSession.dataTask(with: request) { [weak self] (data, response, error) in
            self?.processRequest(data: data, response: response as? HTTPURLResponse, error: error, parseResult: parseResultHandler, completion: completionHandler)
        }
        
        task.resume()
        
        return task
    }
    
    // Search for the password leak
    
     func search(password: String, completion completionHandler: @escaping (() throws -> UInt) -> Swift.Void) throws -> URLSessionTask {
        let sha1 = password.sha1(string: password)
        return try self.searchRange(with: sha1, completion: completionHandler)
    }
    
    // search by prefix
    
    @discardableResult
    public func searchRange(with sha1: String, completion completionHandler: @escaping (() throws -> UInt) -> Swift.Void) throws -> URLSessionTask {
        
        let sha1 = sha1.uppercased()
        let prefixIndex = sha1.index(sha1.startIndex, offsetBy: 5)
        let prefix: String = String(sha1[sha1.startIndex..<prefixIndex])
        
        guard let normalized = prefix.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed), (prefix.count == 5) else {
            throw ErrorCode.badRequest
        }
        
        let urlString: String = self.apiPassword + "/\(normalized)"
        
        guard let url = URL(string: urlString) else {
            throw ErrorCode.badRequest
        }
        
        let request = self.generateRequest(with: url)
        
        let processResult: (() throws -> [RangeModel]) -> Swift.Void = { result in
            
            do {
                let values = try result()
                let count = self.search(for: sha1, in: values)
                completionHandler( { return count })
            }
            catch let error {
                completionHandler( { throw error })
            }
        }
        
        return self.sendRequest(request, parseResult: self.parseRangeModels, completion: processResult)
    }
    
    // search the number of times sha1 is pwned in the list result of `apiRange`
    
    fileprivate func search(for sha1: String, in ranges: [RangeModel]) -> UInt {
        let prefixIndex = sha1.index(sha1.startIndex, offsetBy: 5)
        let suffix: String = String(sha1[prefixIndex..<sha1.endIndex])
        
        if let range = ranges.first(where: {
            return $0.suffix == suffix
        }) {
            return range.count
        }
        else {
            return 0
        }
    }
    
    /// parse `RangeModel` list
    
    fileprivate func parseRangeModels(data: Data) throws -> [RangeModel] {
        guard let string = String(data: data, encoding: .utf8) else {
            throw ErrorCode.badRequest
        }
        
        var result: [RangeModel] = []
        
        let lines = string.split(separator: "\r\n")
        lines.forEach { line in
            let components = line.split(separator: ":")
            if (components.count == 2), let count = UInt(components[1]) {
                result.append(RangeModel(suffix: String(components[0]), count: count))
            }
        }
        return result
    }
    
    fileprivate func processRequest<T>(data: Data?, response: HTTPURLResponse?, error: Error?,
                                       parseResult parseResultHandler: (Data) throws -> T,
                                       completion completionHandler: (() throws -> T) -> Swift.Void) {
        
        if let response = response {
            switch(response.statusCode) {
            case 400: completionHandler({ throw ErrorCode.badRequest })
            case 403: completionHandler({ throw ErrorCode.forbidden })
            case 404: completionHandler({ throw ErrorCode.notFound })
            case 406: completionHandler({ throw ErrorCode.notAcceptable })
            case 429:
                var retrySeconds: Int = 2
                if let retry = response.allHeaderFields["Retry-After"] as? String, let seconds = Int(retry) {
                    retrySeconds = seconds
                }
                
                completionHandler({ throw ErrorCode.tooManyRequests(retrySeconds) })
            case 200: ()
            default:
                if let error = error {
                    completionHandler({ throw error })
                }
            }
        }
        
        if let data = data {
            do {
                let objects = try parseResultHandler(data)
                completionHandler({ objects })
            }
            catch let error {
                completionHandler({ throw error })
            }
        }
    }
}

