//
//  UserEntity.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 06/05/25.
//

import Foundation
import FirebaseAuth

struct UserEntity: Identifiable, Codable {
  
  var id: String { uID }
  let uID: String
  var name: String
  var email: String
  var imagePath: String
  var favCharacterIDList: [String]
}

extension UserEntity {
  
  // MARK: Init from FB Auth
  
  init(authUser: User) {
    self.uID = authUser.uid
    self.name = authUser.displayName ?? "No Name"
    self.email = authUser.email ?? "No Email"
    self.imagePath = authUser.photoURL?.absoluteString ?? "AllHouses-IC"
    self.favCharacterIDList = []
  }
  
  // MARK: Init from FB Document
  
  init?(from data: [String: Any], uid: String) {
    guard let email = data["email"] as? String else { return nil }
    let imageURL = data["photoURL"] as? URL
    self.uID = uid
    self.name = data["name"] as? String ?? "No Name"
    self.email = email
    self.imagePath = imageURL?.absoluteString ?? "AllHouses-IC"
    self.favCharacterIDList = data["favoriteChatacters"] as? [String] ?? []
  }
}
