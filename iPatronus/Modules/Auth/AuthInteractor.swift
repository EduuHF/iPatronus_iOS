//
// AuthInteractor.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation

// MARK: Methods of AuthInteractorProtocol

class AuthInteractor: AuthInteractorProtocol {
  
  // MARK: - Properties and Vars

  weak var presenter: AuthInteractorToPresenterProtocol?
  private let worker: AuthInteractorToWorkerProtocol

  @Published private(set) var dataEntity = AuthInteractorDataEntity()

  // MARK: - Lifecycle Methods

  init(worker: AuthInteractorToWorkerProtocol) {
    self.worker = worker
  }

  // MARK: Private Methods
  
  private func makeUserAuth(email: String, password: String) {
    
    guard email.isValidEmail() else {
      presenter?.onUserAuthFail(errorMsg: "E-mail Invalid, Please type an valid e-mail address.")
      return
    }
    
    guard password.isValidPass() else {
      presenter?.onUserAuthFail(errorMsg: "Password Invalid, Password must be at least 6 characters long and include at least one letter and one number.")
      return
    }
    
    worker.onUserAuth(email: email, password: password)
  }

  // MARK: Public Methods

}

// MARK: - PresenterToInteractorProtocol Methods

extension AuthInteractor: AuthPresenterToInteractorProtocol {
  
  func onModuleLoad() {}
  func onModuleRefresh() {}
  
  func onUserAuthWithGoogle() {
    worker.onUserAuthWithGoogle()
  }
  
  func onUserAuth(email: String, password: String) {
    makeUserAuth(email: email, password: password)
  }
}

// MARK: - WorkerToInteractorProtocol Methods

extension AuthInteractor: AuthWorkerToInteractorProtocol {
  
  func onUserAuthSuccess(user: UserEntity) {
    SessionManager.shared.userData = user
    SessionManager.shared.onFetchFavCharacterList()
    presenter?.onUserAuthSuccess()
  }
  
  func onUserAuthFail(error: APIError) {
    presenter?.onUserAuthFail(errorMsg: error.errorDescription ?? "Unknown Error, Try Later...")
  }
}
