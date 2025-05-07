//
// MainProtocols.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

protocol MainPresenterProtocol: ObservableObject {
  var viewEntity: MainViewEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
}

protocol MainPresenterToInteractorProtocol: AnyObject {
  var dataEntity: MainInteractorDataEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
}

protocol MainInteractorProtocol: AnyObject {
  var presenter: MainInteractorToPresenterProtocol? { get set }
}

protocol MainInteractorToWorkerProtocol: AnyObject {
 
}

protocol MainInteractorToPresenterProtocol: AnyObject {

}

protocol MainPresenterToRouterProtocol: AnyObject {
  associatedtype ContentView: View
  func build() -> ContentView
}

protocol MainWorkerProtocol: AnyObject {
  var interactor: MainWorkerToInteractorProtocol? { get set }
}

protocol MainWorkerToInteractorProtocol: AnyObject {}
