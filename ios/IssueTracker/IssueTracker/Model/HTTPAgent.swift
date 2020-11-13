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
    case PUT
	case PATCH
	case DELETE
}

enum NetworkError: Error {
    case URLError
    case responseError
}

class HTTPAgent: LoginProtocol {
    static let shared = HTTPAgent()
    let session = URLSession.shared
    
	func sendRequest(from urlString: String, method: HTTPMethod, body: Data? = nil, completion: ((Result<Data, NetworkError>) -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            completion?(.failure(.URLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion?(.failure(.responseError))
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode),
                  let data = data else {
                completion?(.failure(.responseError))
                return
            }
            
            completion?(.success(data))
        }.resume()
    }
    
    func sendImage(from urlString: String, boundary: String, method: HTTPMethod, body: Data? = nil, completion: ((Result<Data, NetworkError>) -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            completion?(.failure(.URLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body = body {
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion?(.failure(.responseError))
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode),
                  let data = data else {
                completion?(.failure(.responseError))
                return
            }
            
            completion?(.success(data))
        }.resume()
    }
    
    func createBody(boundary: String, data: Data, mimeType: String, filename: String) -> Data {
        var body = Data()
        let imgDataKey = "imgs"
        let boundaryPrefix = "--\(boundary)\r\n"
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(imgDataKey)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--".appending(boundary.appending("--")).data(using: .utf8)!)
        return body as Data
    }
    
    func githubLoginAction() {
        let urlString = "https://github.com/login/oauth/authorize?client_id=cdb63bb140a5645dbcfc&scope=user"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func accessToken(with code: String) {
        let urlString = "https://github.com/login/oauth/access_token"
        let parameters = ["client_id": "cdb63bb140a5645dbcfc",
                           "client_secret": "1f4889ae44ee8717c76d681f5d20835e0382c61e",
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
                        self.getUser(token: token, completion: { statusCode, id, token in
                            NotificationCenter.default.post(name: .googleLoginSuccess, object: self, userInfo: ["statusCode": statusCode, "id": id, "pw": token])
                        })
                    }
                }
            }
            task.resume()
        } catch {
            print(error)
        }
    }
    
    func getUser(token: String, completion: ((_ statusCode: Int, _ id: String, _ token: String) -> Void)? = nil) {
        /*
         수정 - 토큰을 서버에서 유지해야할듯
         */
        let urlString = "https:api.github.com/user"
        UserDefaults.standard.set(token, forKey: "GoogleToken")        
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            let userData = try? JSONSerialization.jsonObject(with: data!) as? [String: Any]
            let id = userData?["id"] as? Int
            
            completion?(httpResponse.statusCode,
                        String(id!),
                        token)
        }
        task.resume()
    }
	
	public func loadImage(urlString: String, reDownload: Bool = false, completion: @escaping (Result<String, NetworkError>) -> Void) {
		
		guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
			  let url = URL(string: encodedString) else {
			print(urlString)
			completion(.failure(.URLError))
			return
		}
		
		let path = localFilePath(for: url).path
		
		if !reDownload && FileManager.default.fileExists(atPath: path) {
			completion(.success(path))
			return
		}
			
		session.downloadTask(with: url) { location, response, error in
			if error != nil { fatalError() }
			guard let response = response as? HTTPURLResponse,
				  (200...299).contains(response.statusCode),
				  let url = response.url,
				  let location = location else {
				fatalError()
			}
			
			let destinationURL = self.localFilePath(for: url)
			
			try? FileManager.default.removeItem(at: destinationURL)
			
			do {
				try FileManager.default.copyItem(at: location, to: destinationURL)
				completion(.success(destinationURL.path))
			} catch let error {
				fatalError("Copy Error: \(error.localizedDescription)")
			}
		}.resume()
	}
	
	func localFilePath(for url: URL) -> URL {
		let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
		return documentsPath.appendingPathComponent(url.lastPathComponent)
	}
}
