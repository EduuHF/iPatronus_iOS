//
// MainPresenter.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation

// MARK: Methods of MainPresenter

class MainPresenter: ObservableObject {
  // MARK: - Properties and Vars

  private let interactor: MainPresenterToInteractorProtocol
  private let router: any MainPresenterToRouterProtocol

  @Published var viewEntity = MainViewEntity()

  // MARK: - Lifecycle Methods

  init(interactor: MainPresenterToInteractorProtocol,
       router: any MainPresenterToRouterProtocol) {
    self.interactor = interactor
    self.router = router
  }
}

// MARK: Extension Methods

extension MainPresenter: MainPresenterProtocol {
  
  func onModuleLoad() {}
  func onModuleRefresh() {}
}

// MARK: - InteractorToPresenterProtocol Methods

extension MainPresenter: MainInteractorToPresenterProtocol {}
