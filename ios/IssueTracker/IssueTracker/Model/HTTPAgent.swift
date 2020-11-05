//
//  HTTPAgent.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/26.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation
import UIKit

protocol LoginProtocol {
    func  githubLoginAction()
}

enum HTTPMethod: String {
    case GET
    case POST
}

enum NetworkError: Error {
    case URLError
    case responseError
}

class HTTPAgent: LoginProtocol {
    static let shared = HTTPAgent()
    let session = URLSession.shared
    
    func sendRequest(from urlString: String, method: HTTPMethod, body: Data? = nil, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.URLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.responseError))
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode),
                  let data = data else {
                completion(.failure(.responseError))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
    
    func githubLoginAction() {
        let urlString = "https://github.com/login/outh/authorize?client_id=e58f7514be065a86ab47&scope=user"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func accessToken(with code: String) {
        let urlString = "https://github.com/login/oauth/access_token"
        let parameters = ["client_id": "e58f7514be065a86ab47",
                           "client_secret": "94991060a59ddc27967a0cdac850a39ff2cc37ab",
                           "code": code]
        guard let url = URL(string: urlString) else {
            return
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            var request = URLRequest.init(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: request) { data, _, _ in
                if let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                    as? [String: Any] {
                    if let token = json["access_token"] as? String {
                        self.getUser(token: token, completion: { statusCode in
                            NotificationCenter.default.post(name: Notification.googleLoginSuccess, object: self, userInfo: ["statusCode": statusCode])
                        })
                    }
                }
            }
            task.resume()
        } catch {
            print(error)
        }
    }
    
    func getUser(token: String, completion: ((Int) -> Void)? = nil) {
        let urlString = "https:api.github.com/user"
        UserDefaults.standard.set(token, forKey: "GoogleToken")        
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { _, response, _ in
            if let httpResponse = response as? HTTPURLResponse {
                completion?(httpResponse.statusCode)
            }
        }
        task.resume()
    }
}
