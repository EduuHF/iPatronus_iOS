//
// HomeViewEntity.swift
//
// Create by Eduardo Herrera
//

import SwiftUI

struct HomeViewEntity {

  var houseDataList: [HouseSliderViewEntity] = getHouseListForLoading()
  var characterDataList: [CharacterGripViewEntity] = getCharacterListForLoading()
  var selectedHouseID: UUID? = nil
  var primaryColor: Color = AppColors.colorBlue
  var secondaryColor: Color = AppColors.colorBlue
  
  var hasError: Bool = false
  var someErrorMgs: String?
  
  // MARK: Mocks, Loadings
  
  static private func getHouseListForLoading() -> [HouseSliderViewEntity] {
    return [.init(isLoading: true)]
  }
  
  static private func getCharacterListForLoading() -> [CharacterGripViewEntity] {
    return [
      .init(isLoading: true),
      .init(isLoading: true),
      .init(isLoading: true),
      .init(isLoading: true),
      .init(isLoading: true),
      .init(isLoading: true)
    ]
  }
}

