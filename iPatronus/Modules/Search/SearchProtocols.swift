//
// SearchProtocols.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI
import SwiftData

protocol SearchPresenterProtocol: ObservableObject {
  var viewEntity: SearchViewEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
  func onSearchCharacter(term: String?)
}

protocol SearchPresenterToInteractorProtocol: AnyObject {
  var dataEntity: SearchInteractorDataEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
  func onSearchCharacter(term: String?)
}

protocol SearchInteractorProtocol: AnyObject {
  var presenter: SearchInteractorToPresenterProtocol? { get set }
}

protocol SearchInteractorToPresenterProtocol: AnyObject {
  func onUpdateData(data: SearchInteractorDataEntity)
}

protocol SearchPresenterToRouterProtocol: AnyObject {
  associatedtype ContentView: View
  func build(modelContext: ModelContext) -> ContentView
}

