//
// AuthRouter.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

// MARK: Methods of AuthRouter

class AuthRouter: AuthPresenterToRouterProtocol {
  func build() -> AuthView {
    let worker = AuthWorker()
    let interactor = AuthInteractor(worker: worker)
    let presenter = AuthPresenter(interactor: interactor, router: self)

    let view = AuthView(presenter: presenter)
    interactor.presenter = presenter
    worker.interactor = interactor

    return view
  }
}
