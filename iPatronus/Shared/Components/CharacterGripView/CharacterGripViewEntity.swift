//
//  CharacterGripViewEntity.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 03/05/25.
//

import Foundation

struct CharacterGripViewEntity: Identifiable, Hashable {
  
  var id: UUID
  var name: String?
  var gender: String?
  var houseName: String?
  var imagePath: String?
  var isLoading: Bool
}

extension CharacterGripViewEntity {
  
  init(isLoading: Bool) {
    self.id = UUID()
    self.name = ""
    self.gender = ""
    self.houseName = ""
    self.imagePath = ""
    self.isLoading = isLoading
  }
  
  init(entity: CharacterEntity) {
    self.id = entity.id
    self.name = entity.name
    self.gender = entity.gender
    self.houseName = entity.houseName
    self.imagePath = entity.imagePath ?? ""
    self.isLoading = false
  }
}
