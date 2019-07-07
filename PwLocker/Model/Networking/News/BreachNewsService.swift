//
//  BreachNewsService.swift
//  PwLocker
//
//  Created by Tavares on 30/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

class BreachNewsService {
    
    private var task: URLSessionDataTask?
    private var breachNewsSession: URLSession
    fileprivate let apiBreaches: String = "https://haveibeenpwned.com/api/breaches"

    init(breachNewsSession: URLSession = URLSession(configuration: .default)) {
        self.breachNewsSession = breachNewsSession
    }

    func getBreachesNews(completionHandler: @escaping (Bool, [BreachModel]?) -> Void) {

        guard let breachesNewsURL = URL(string: apiBreaches) else { return }

        task = breachNewsSession.dataTask(with: breachesNewsURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else  {
                    completionHandler(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(false, nil)
                    return
                }
                guard let responseBreaches = try? JSONDecoder().decode([BreachModel].self, from: data) else {
                    completionHandler(false, nil)
                    return
                }
                completionHandler(true, responseBreaches)
            }
        }
        task?.resume()
    }
}

