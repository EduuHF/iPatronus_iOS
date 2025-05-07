//
// ProfilePresenter.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation

// MARK: Methods of ProfilePresenter

class ProfilePresenter: ObservableObject {
  // MARK: - Properties and Vars

  private let interactor: ProfilePresenterToInteractorProtocol
  private let router: any ProfilePresenterToRouterProtocol

  @Published var viewEntity = ProfileViewEntity()

  // MARK: - Lifecycle Methods

  init(interactor: ProfilePresenterToInteractorProtocol,
       router: any ProfilePresenterToRouterProtocol) {
    self.interactor = interactor
    self.router = router
  }

}

// MARK: Extension Methods

extension ProfilePresenter: ProfilePresenterProtocol {
  
  func onModuleLoad() {}
  func onModuleRefresh() {
    interactor.onModuleRefresh()
  }
}

// MARK: - InteractorToPresenterProtocol Methods

extension ProfilePresenter: ProfileInteractorToPresenterProtocol {
  func onUpdateData(data: ProfileInteractorDataEntity) {
    self.viewEntity = ProfileViewEntity(
      favCharacterDataList: data.favCharacterDataList.map { CharacterGripViewEntity(entity: $0) }
    )
  }
}
