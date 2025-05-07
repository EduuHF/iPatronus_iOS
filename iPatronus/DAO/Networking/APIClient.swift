//
//  APIClient.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 02/05/25.
//

import Foundation

protocol APIClientProtocol {
  func perform<T: APIResource>(_ resource: T, completion: @escaping (Result<T.Response, APIError>) -> Void)
}

final class APIClient {
  
  // MARK: Shared Instance
  
  static let shared: APIClientProtocol = APIClient()
  
  private init() {}
  
  // MARK: Private Methods
  
  private func makePerform<T: APIResource>(_ resource: T,
                                           retries: Int = 1,
                                           completion: @escaping (Result<T.Response, APIError>) -> Void) {
    
    guard let mainRequest = resource.mainRequest else {
      completion(.failure(APIError.invalidRequest))
      return
    }
    
    URLSession.shared.dataTask(with: mainRequest) { data, response, error in
      
      if let nsErrror = error as? NSError,
          nsErrror.code == NSURLErrorNetworkConnectionLost,
          retries > 0 {
        self.makePerform(resource, retries: retries - 1, completion: completion)
        return
      }
      
      if let error = error {
        completion(.failure(APIError.decodingError(error)))
        return
      }
      
      guard let resultData = data else {
        completion(.failure(APIError.invalidResponse))
        return
      }
      
      do {
        let dResponse = try JSONDecoder().decode(T.Response.self, from: resultData)
        completion(.success(dResponse))
      } catch {
        completion(.failure(APIError.decodingError(error)))
      }
    }.resume()
  }
}

// MARK: Extension Methods

extension APIClient: APIClientProtocol {
  
  func perform<T>(_ resource: T,
                  completion: @escaping (Result<T.Response, APIError>) -> Void) where T : APIResource {
    self.makePerform(resource,
                     completion: completion)
  }
}
