//
// DetailRouter.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

// MARK: Methods of DetailRouter

class DetailRouter: DetailPresenterToRouterProtocol {
  func build(data: CharacterGripViewEntity) -> DetailView {
    let interactor = DetailInteractor(data: data)
    let presenter = DetailPresenter(interactor: interactor, router: self)

    let view = DetailView(presenter: presenter)
    interactor.presenter = presenter

    return view
  }
}
