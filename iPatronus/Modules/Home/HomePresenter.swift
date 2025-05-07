//
// HomePresenter.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation
import SwiftUICore

// MARK: Methods of HomePresenter

class HomePresenter: ObservableObject {
  // MARK: - Properties and Vars

  private let interactor: HomePresenterToInteractorProtocol
  private let router: any HomePresenterToRouterProtocol

  @Published var viewEntity = HomeViewEntity()

  // MARK: - Lifecycle Methods

  init(interactor: HomePresenterToInteractorProtocol,
       router: any HomePresenterToRouterProtocol) {
    self.interactor = interactor
    self.router = router
  }
}

// MARK: Extension Methods

extension HomePresenter: HomePresenterProtocol {
  
  func onModuleLoad() {}
  
  func onModuleRefresh() {
    interactor.onModuleRefresh()
  }
  
  func onHouseSelected(house: HouseSliderViewEntity) {
    interactor.onHouseSelected(house: house)
  }
}

// MARK: - InteractorToPresenterProtocol Methods

extension HomePresenter: HomeInteractorToPresenterProtocol {
  
  func onFetchCharacterListFail(errorMsg: String?) {
    DispatchQueue.main.async {
      self.viewEntity = HomeViewEntity(
        hasError: true,
        someErrorMgs: errorMsg
      )
    }
  }
  
  func onUpdateData(data: HomeInteractorDataEntity) {
    DispatchQueue.main.async {
      self.viewEntity = HomeViewEntity(
        houseDataList: data.houseDataList.map { HouseSliderViewEntity(entity: $0) },
        characterDataList: data.characterDataList.map { CharacterGripViewEntity(entity: $0) },
        selectedHouseID: data.houseSelected?.id,
        primaryColor: data.houseSelected?.primaryColor ?? AppColors.colorBlue,
        secondaryColor: data.houseSelected?.secondaryColor ?? AppColors.colorBlue
      )
    }
  }
}
