//
// DetailPresenter.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation

// MARK: Methods of DetailPresenter

class DetailPresenter: ObservableObject {
  // MARK: - Properties and Vars

  private let interactor: DetailPresenterToInteractorProtocol
  private let router: any DetailPresenterToRouterProtocol

  @Published var viewEntity = DetailViewEntity()

  // MARK: - Lifecycle Methods

  init(interactor: DetailPresenterToInteractorProtocol,
       router: any DetailPresenterToRouterProtocol) {
    self.interactor = interactor
    self.router = router
  }
}

// MARK: Extension Methods

extension DetailPresenter: DetailPresenterProtocol {
  
  func onFavTap() {
    interactor.onFavTap()
  }
  
  func onModuleLoad() {}
  func onModuleRefresh() {
    interactor.onModuleRefresh()
  }
}

// MARK: - InteractorToPresenterProtocol Methods

extension DetailPresenter: DetailInteractorToPresenterProtocol {
  func onUpdateData(data: DetailInteractorDataEntity) {
    DispatchQueue.main.async {
      self.viewEntity = DetailViewEntity(
        characterInfo: data.characterInfo,
        primaryColor: data.characterHouse?.primaryColor,
        secondaryColor: data.characterHouse?.secondaryColor,
        isFav: data.isFav
      )
    }
  }
}
