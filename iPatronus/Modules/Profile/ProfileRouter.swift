//
// ProfileRouter.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI
import SwiftData

// MARK: Methods of ProfileRouter

class ProfileRouter: ProfilePresenterToRouterProtocol {
  func build(modelContext: ModelContext) -> ProfileView {
    let interactor = ProfileInteractor(modelContext: modelContext)
    let presenter = ProfilePresenter(interactor: interactor, router: self)

    let view = ProfileView(presenter: presenter)
    interactor.presenter = presenter

    return view
  }
}
