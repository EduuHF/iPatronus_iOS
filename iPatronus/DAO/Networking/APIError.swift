//
//  APIError.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 02/05/25.
//

import Foundation

enum APIError: Error, LocalizedError {
  
  case invalidRequest
  case invalidResponse
  case invalidFBConfiguration
  case decodingError(Error)
  case unknown(Error)

  var errorDescription: String? {
    switch self {
    case .invalidRequest:
      return "Oups! Invalid Request. Please try later."
    case .invalidResponse:
      return "Oups! Invalid response from server. Please try later."
    case .invalidFBConfiguration:
      return "Oups! Invalid Google configuration. Please try later."
    case .decodingError(let error):
      return "Oups! we have an error when try get data, \(error.localizedDescription). Please try Later."
    case .unknown(let error):
      return "Oups! we have an unknown error, \(error.localizedDescription). Please try Later."
    }
  }
}
