//
// DetailProtocols.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

protocol DetailPresenterProtocol: ObservableObject {
  var viewEntity: DetailViewEntity { get }
  func onFavTap()
  func onModuleLoad()
  func onModuleRefresh()
}

protocol DetailPresenterToInteractorProtocol: AnyObject {
  var dataEntity: DetailInteractorDataEntity { get }
  func onFavTap()
  func onModuleLoad()
  func onModuleRefresh()
}

protocol DetailInteractorProtocol: AnyObject {
  var presenter: DetailInteractorToPresenterProtocol? { get set }
}

protocol DetailInteractorToPresenterProtocol: AnyObject {
  func onUpdateData(data: DetailInteractorDataEntity)
}

protocol DetailPresenterToRouterProtocol: AnyObject {
  associatedtype ContentView: View
  func build(data: CharacterGripViewEntity) -> ContentView
}
