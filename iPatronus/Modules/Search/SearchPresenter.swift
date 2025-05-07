//
// SearchPresenter.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation

// MARK: Methods of SearchPresenter

class SearchPresenter: ObservableObject {
  // MARK: - Properties and Vars

  private let interactor: SearchPresenterToInteractorProtocol
  private let router: any SearchPresenterToRouterProtocol

  @Published var viewEntity = SearchViewEntity()

  // MARK: - Lifecycle Methods

  init(interactor: SearchPresenterToInteractorProtocol,
       router: any SearchPresenterToRouterProtocol) {
    self.interactor = interactor
    self.router = router
  }
}

// MARK: Extension Methods

extension SearchPresenter: SearchPresenterProtocol {
  
  func onModuleLoad() {}
  func onModuleRefresh() {
    interactor.onModuleRefresh()
  }
  
  func onSearchCharacter(term: String?) {
    interactor.onSearchCharacter(term: term)
  }
}

// MARK: - InteractorToPresenterProtocol Methods

extension SearchPresenter: SearchInteractorToPresenterProtocol {
  func onUpdateData(data: SearchInteractorDataEntity) {
    DispatchQueue.main.async {
      self.viewEntity = SearchViewEntity(
        characterDataList: data.filterCharacterList.map { CharacterGripViewEntity(entity: $0) }
      )
    }
  }
}
