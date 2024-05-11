//
//  APIManager.swift
//  ScrollableGrid
//
//  Created by Saurav Sagar on 11/05/24.
//

import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidUrl
    case invalidData
    case network(Error?)
}

typealias Handler<T> = (Result<T, DataError>) -> Void

final class APIManager {
    
    static let shared: APIManager = APIManager()
    private init() {}
    
    func request<T: Decodable>(
        moduleType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidUrl))
            debugPrint("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(moduleType, from: data)
                completion(.success(response))
                
            } catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
}
