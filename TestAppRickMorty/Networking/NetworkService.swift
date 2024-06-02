//
//  NetworkService.swift
//  TestAppRickMorty
//
//  Created by NikoS on 27.05.2024.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    enum NetworkServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func fetch<T: Codable>(_ request: NetworkRequest,
                                      model: T.Type,
                                      completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(NetworkServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(model.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request(from networkRequest: NetworkRequest) -> URLRequest? {
        guard let url = networkRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = networkRequest.httpMethod
        
        return request
    }
}
