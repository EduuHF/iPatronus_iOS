//
// HomeRouter.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI
import SwiftData

// MARK: Methods of HomeRouter

class HomeRouter: HomePresenterToRouterProtocol {
  func build(modelContext: ModelContext) -> HomeView {
    let worker = HomeWorker()
    let interactor = HomeInteractor(worker: worker,
                                    modelContext: modelContext)
    let presenter = HomePresenter(interactor: interactor,
                                  router: self)

    let view = HomeView(presenter: presenter)
    interactor.presenter = presenter
    worker.interactor = interactor

    return view
  }
}
