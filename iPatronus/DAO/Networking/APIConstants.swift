//
//  APIConstants.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 02/05/25.
//

import Foundation

enum APIConstants {
  
  static let baseURL = URL(string: "https://hp-api.onrender.com/api")
  
  enum EndpointPath {
    static let characterList = "/characters"
  }
}
