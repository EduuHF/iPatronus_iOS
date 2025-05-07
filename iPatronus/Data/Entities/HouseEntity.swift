//
//  HouseEntity.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 28/04/25.
//

import SwiftData
import SwiftUI

@Model
final class HouseEntity {
  @Attribute(.unique) var id: UUID
  var name: String
  var imagePath: String
  var primaryColorHex: String
  var secondaryColorHex: String
  
  init(id: UUID = UUID(),
       name: String = "",
       imagePath: String = "",
       primaryColorHex: String = "",
       secondaryColorHex: String = "") {
    self.id = id
    self.name = name
    self.imagePath = imagePath
    self.primaryColorHex = primaryColorHex
    self.secondaryColorHex = secondaryColorHex
  }
  
  var primaryColor: Color {
    Color(hex: primaryColorHex)
  }
  
  var secondaryColor: Color {
    Color(hex: secondaryColorHex)
  }
}

// MARK: Extension Methods

extension HouseEntity {
  
  // MARK: Mocks
  
  static var houseGryffindorMock: HouseEntity {
    HouseEntity(
      name: "Gryffindor",
      imagePath: "Gryffindor-IC",
      primaryColorHex: "#7F0909",
      secondaryColorHex: "#FFC500"
    )
  }
  
  static var houseSlytherinMock: HouseEntity {
    HouseEntity(
      name: "Slytherin",
      imagePath: "Slytherin-IC",
      primaryColorHex: "#1A472A",
      secondaryColorHex: "#C0C0C0"
    )
  }
  
  static var houseRavenclawMock: HouseEntity {
    HouseEntity(
      name: "Ravenclaw",
      imagePath: "Ravenclaw-IC",
      primaryColorHex: "#0E1A40",
      secondaryColorHex: "#946B2D"
    )
  }
  
  static var houseHufflepuffMock: HouseEntity {
    HouseEntity(
      name: "Hufflepuff",
      imagePath: "Hufflepuff-IC",
      primaryColorHex: "#FFDB00",
      secondaryColorHex: "#60605C"
    )
  }
  
  static var houseListMock: [HouseEntity] {
    [
      houseGryffindorMock,
      houseSlytherinMock,
      houseRavenclawMock,
      houseHufflepuffMock
    ]
  }
  
  static func from(houseName: String?) -> HouseEntity? {
    houseListMock.first { $0.name.lowercased() == houseName?.lowercased() }
  }
}
