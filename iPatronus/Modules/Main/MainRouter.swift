//
// MainRouter.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

// MARK: Methods of MainRouter

class MainRouter: MainPresenterToRouterProtocol {
  func build() -> MainView {
    let worker = MainWorker()
    let interactor = MainInteractor(worker: worker)
    let presenter = MainPresenter(interactor: interactor, router: self)

    let view = MainView(presenter: presenter)
    interactor.presenter = presenter
    worker.interactor = interactor

    return view
  }
}
