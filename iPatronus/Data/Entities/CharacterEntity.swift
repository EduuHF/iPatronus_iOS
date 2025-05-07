//
//  CharacterEntity.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 01/05/25.
//

import SwiftData
import SwiftUI

@Model
final class CharacterEntity {
  @Attribute(.unique) var id: UUID
  var name: String?
  var gender: String?
  var houseName: String?
  var imagePath: String?
  
  init(id: UUID = UUID(),
       name: String? = "",
       gender: String? = "",
       houseName: String? = "",
       imagePath: String? = "") {
    self.id = id
    self.name = name
    self.gender = gender
    self.houseName = houseName
    self.imagePath = imagePath
  }
}

// MARK: From DTO Methods

extension CharacterEntity {
  static func from(dto: CharacterEntityDTO?) -> CharacterEntity? {
    guard let data = dto,
          let id = data.id,
          let uuid = UUID(uuidString: id)
    else { return nil }

    return CharacterEntity(id: uuid,
                           name: data.name,
                           gender: data.gender,
                           houseName: data.house,
                           imagePath: data.image)
  }
}
