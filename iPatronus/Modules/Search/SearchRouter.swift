//
// SearchRouter.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI
import SwiftData

// MARK: Methods of SearchRouter

class SearchRouter: SearchPresenterToRouterProtocol {
  func build(modelContext: ModelContext) -> SearchView {
    let interactor = SearchInteractor(modelContext: modelContext)
    let presenter = SearchPresenter(interactor: interactor, router: self)

    let view = SearchView(presenter: presenter)
    interactor.presenter = presenter

    return view
  }
}
