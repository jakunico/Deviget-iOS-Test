//
//  Network.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation

enum NetworkResponse<T: Decodable> {
    case success(T)
    case error(NetworkError)
}

enum NetworkError {
    case networking(Error)
    case parsing(Error)
    case other
}

typealias NetworkCompletion<T: Decodable> = (NetworkResponse<T>) -> Void

class Network {
    static let shared = Network()
    
    let session = URLSession(configuration: .default)
    let baseComponents = URLComponents() .. {
        $0.scheme = "https"
        $0.host = "reddit.com"
    }
    
    private init() { }
    
    func top(request: TopRequest, completion: @escaping NetworkCompletion<ListingRoot>) {
        let components = baseComponents .. {
            $0.path = "/top.json"
            $0.queryItems = [
                .init(name: "t", value: request.time.rawValue),
                .init(name: "after", value: request.after),
                .init(name: "limit", value: String(request.limit))
            ]
        }
        
        get(components: components, completion: completion)
    }
    
    private func get<T: Decodable>(components: URLComponents, completion: @escaping NetworkCompletion<T>) {
        guard let url = components.url else {
            fatalError("Networking: Unable to build URL to make a request")
        }
        
        session.dataTask(with: url, completionHandler: { data, response, error in
            if let response = response,
                response.isSuccess, let data = data {
                
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(NetworkResponse.success(object))
                } catch {
                    completion(NetworkResponse.error(.parsing(error)))
                }
                
            } else if let error = error {
                completion(NetworkResponse.error(.networking(error)))
            } else {
                completion(NetworkResponse.error(.other))
            }
        }).resume()
    }
    
}

private extension URLResponse {
    var isSuccess: Bool {
        guard let httpResponse = self as? HTTPURLResponse else { return false }
        return (200 ... 399).contains(httpResponse.statusCode)
    }
}
