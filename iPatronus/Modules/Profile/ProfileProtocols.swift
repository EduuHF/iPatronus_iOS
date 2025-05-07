//
// ProfileProtocols.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI
import SwiftData

protocol ProfilePresenterProtocol: ObservableObject {
  var viewEntity: ProfileViewEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
}

protocol ProfilePresenterToInteractorProtocol: AnyObject {
  var dataEntity: ProfileInteractorDataEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
}

protocol ProfileInteractorProtocol: AnyObject {
  var presenter: ProfileInteractorToPresenterProtocol? { get set }
}

protocol ProfileInteractorToPresenterProtocol: AnyObject {
  func onUpdateData(data: ProfileInteractorDataEntity)
}

protocol ProfilePresenterToRouterProtocol: AnyObject {
  associatedtype ContentView: View
  func build(modelContext: ModelContext) -> ContentView
}
