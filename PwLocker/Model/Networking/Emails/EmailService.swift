//
//  EmailService.swift
//  PwLocker
//
//  Created by Tavares on 30/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

class EmailService {
    
    private var task: URLSessionDataTask?
    private var emailSession: URLSession
    fileprivate let apiEmailBreach: String = "https://haveibeenpwned.com/api/v2/breachedaccount/"
    
    init(emailSession: URLSession = URLSession(configuration: .default)) {
        self.emailSession = emailSession
    }
    
    func getEmailBreach(account: String, callback: @escaping (Bool, [EmailBreachModel]?) -> Void) {
        
        guard let emailURL = URL(string: apiEmailBreach + account) else { return }
        
        task = emailSession.dataTask(with: emailURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else  {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseBreaches = try? JSONDecoder().decode([EmailBreachModel].self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseBreaches)
            }
        }
        task?.resume()
    }
}
