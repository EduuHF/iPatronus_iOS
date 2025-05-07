//
//  CharacterEntityDTO.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 02/05/25.
//

import Foundation

struct CharacterEntityDTO: Decodable {
  
  var id: String?
  var name: String?
  var gender: String?
  var house: String?
  var image: String?
}
