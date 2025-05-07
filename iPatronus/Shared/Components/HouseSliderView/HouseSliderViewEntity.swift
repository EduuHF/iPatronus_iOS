//
//  HouseSliderViewEntity.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 03/05/25.
//

import Foundation
import SwiftUI

struct HouseSliderViewEntity: Identifiable, Hashable {
  
  let id: UUID
  let name: String
  let imagePath: String
  let primaryColor: Color
  let secondaryColor: Color
  let isLoading: Bool
}

extension HouseSliderViewEntity {
  
  init(isLoading: Bool) {
    self.id = UUID()
    self.name = ""
    self.imagePath = ""
    self.primaryColor = .clear
    self.secondaryColor = .clear
    self.isLoading = isLoading
  }
  
  init(entity: HouseEntity) {
    self.id = entity.id
    self.name = entity.name
    self.imagePath = entity.imagePath 
    self.primaryColor = Color(hex: entity.primaryColorHex)
    self.secondaryColor = Color(hex: entity.secondaryColorHex)
    self.isLoading = false
  }
}
