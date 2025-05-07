//
//  FetchCharacterListResource.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 02/05/25.
//

import Foundation

struct FetchCharacterListResource: APIResource {
  
  typealias Response = [CharacterEntityDTO]
  
  var baseURL: URL? { APIConstants.baseURL }
  var urlPath: String { APIConstants.EndpointPath.characterList }
  var method: HTTPMethod { .get }
  var headers: [String : String]? { nil }
  var queryItems: [URLQueryItem]? { nil }
  var body: Data? { nil }
}
