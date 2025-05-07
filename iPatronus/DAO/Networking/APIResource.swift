//
//  APIResource.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 02/05/25.
//

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

protocol APIResource {
  
  associatedtype Response: Decodable
  var baseURL: URL? { get }
  var urlPath: String { get }
  var method: HTTPMethod { get }
  var headers: [String : String]? { get }
  var queryItems: [URLQueryItem]? { get }
  var body: Data? { get }
}

extension APIResource {
  var mainRequest: URLRequest? {
    guard let baseURL = baseURL else { return nil }
    guard var components = URLComponents(url: baseURL.appendingPathComponent(urlPath), resolvingAgainstBaseURL: false) else { return nil }
    components.queryItems = queryItems
    guard let mainURL = components.url else { return nil }
    
    var request = URLRequest(url: mainURL)
    request.httpMethod = method.rawValue
    request.httpBody = body
    headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
    return request
  }
}


