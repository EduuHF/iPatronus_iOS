//
// HomeProtocols.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI
import SwiftData

protocol HomePresenterProtocol: ObservableObject {
  var viewEntity: HomeViewEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
  func onHouseSelected(house: HouseSliderViewEntity)
}

protocol HomePresenterToInteractorProtocol: AnyObject {
  var dataEntity: HomeInteractorDataEntity { get }
  func onModuleLoad()
  func onModuleRefresh()
  func onHouseSelected(house: HouseSliderViewEntity)
}

protocol HomeInteractorProtocol: AnyObject {
  var presenter: HomeInteractorToPresenterProtocol? { get set }
}

protocol HomeInteractorToWorkerProtocol: AnyObject {
  func fetchCharacterList()
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
  func onUpdateData(data: HomeInteractorDataEntity)
  func onFetchCharacterListFail(errorMsg: String?)
}

protocol HomePresenterToRouterProtocol: AnyObject {
  associatedtype ContentView: View
  func build(modelContext: ModelContext) -> ContentView
}

protocol HomeWorkerProtocol: AnyObject {
  var interactor: HomeWorkerToInteractorProtocol? { get set }
}

protocol HomeWorkerToInteractorProtocol: AnyObject {
  func onFetchCharacterListSuccess(dataList: [CharacterEntityDTO])
  func onFetchCharacterListFail(error: APIError)
}
