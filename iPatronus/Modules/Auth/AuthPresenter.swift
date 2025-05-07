//
// AuthPresenter.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation

// MARK: Methods of AuthPresenter

class AuthPresenter: ObservableObject {
  // MARK: - Properties and Vars

  private let interactor: AuthPresenterToInteractorProtocol
  private let router: any AuthPresenterToRouterProtocol

  @Published var viewEntity = AuthViewEntity()

  // MARK: - Lifecycle Methods

  init(interactor: AuthPresenterToInteractorProtocol,
       router: any AuthPresenterToRouterProtocol) {
    self.interactor = interactor
    self.router = router
  }
}

// MARK: Extension Methods

extension AuthPresenter: AuthPresenterProtocol {
  
  func onModuleLoad() {}
  func onModuleRefresh() {}
  
  func onUserAuthWithGoogle() {
    interactor.onUserAuthWithGoogle()
  }
  
  func onUserAuth(email: String, password: String) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      LoaderManager.shared.show()
      self.interactor.onUserAuth(email: email, password: password)
    }
  }
}

// MARK: - InteractorToPresenterProtocol Methods

extension AuthPresenter: AuthInteractorToPresenterProtocol {
  
  func onUserAuthSuccess() {
    DispatchQueue.main.async {
      LoaderManager.shared.hide()
      self.viewEntity = AuthViewEntity(
        isUserLoggedIn: true,
      )
    }
  }
  
  func onUserAuthFail(errorMsg: String) {
    DispatchQueue.main.async {
      LoaderManager.shared.hide()
      self.viewEntity = AuthViewEntity(
        isUserLoggedIn: false,
        hasError: true,
        errorTitle: "Fail",
        errorMsg: errorMsg
      )
    }
  }
}
