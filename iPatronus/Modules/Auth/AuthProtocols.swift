//
// AuthProtocols.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

protocol AuthPresenterProtocol: ObservableObject {
  var viewEntity: AuthViewEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
  func onUserAuthWithGoogle()
  func onUserAuth(email: String, password: String)
}

protocol AuthPresenterToInteractorProtocol: AnyObject {
  var dataEntity: AuthInteractorDataEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
  func onUserAuthWithGoogle()
  func onUserAuth(email: String, password: String)
}

protocol AuthInteractorProtocol: AnyObject {
  var presenter: AuthInteractorToPresenterProtocol? { get set }
}

protocol AuthInteractorToWorkerProtocol: AnyObject {
  func onUserAuthWithGoogle()
  func onUserAuth(email: String, password: String)
}

protocol AuthInteractorToPresenterProtocol: AnyObject {
  func onUserAuthSuccess()
  func onUserAuthFail(errorMsg: String)
}

protocol AuthPresenterToRouterProtocol: AnyObject {
  associatedtype ContentView: View
  func build() -> ContentView
}

protocol AuthWorkerProtocol: AnyObject {
  var interactor: AuthWorkerToInteractorProtocol? { get set }
}

protocol AuthWorkerToInteractorProtocol: AnyObject {
  func onUserAuthSuccess(user: UserEntity)
  func onUserAuthFail(error: APIError)
}
