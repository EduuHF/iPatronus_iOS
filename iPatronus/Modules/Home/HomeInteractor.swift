//
// HomeInteractor.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation
import SwiftData

// MARK: Methods of HomeInteractorProtocol

class HomeInteractor: HomeInteractorProtocol {
  
  // MARK: - Properties and Vars
  
  weak var presenter: HomeInteractorToPresenterProtocol?
  private let worker: HomeInteractorToWorkerProtocol
  private let modelContext: ModelContext
  
  @Published private(set) var dataEntity = HomeInteractorDataEntity()
  
  // MARK: - Lifecycle Methods
  
  init(worker: HomeInteractorToWorkerProtocol, modelContext: ModelContext) {
    self.worker = worker
    self.modelContext = modelContext
  }
  
  // MARK: Private Methods
  
  private func onFetchCharacterDataList(dataList: [CharacterEntityDTO]) {
    var characterList: [CharacterEntity] = []
    dataList.forEach { itemDTO in
      if let characterItem = CharacterEntity.from(dto: itemDTO) {
        characterList.append(characterItem)
      }
    }
    
    LocalDataManager.shared.saveAll(characterList, context: self.modelContext)
    self.checkCharacterData()
  }
  
  private func checkHouseData() {
    
    if self.dataEntity.houseDataList.isEmpty {
      let dataList = LocalDataManager.shared.fetchAll(HouseEntity.self,
                                                      context: self.modelContext)
      self.dataEntity.houseDataList = dataList
      self.dataEntity.houseSelected = dataList.first
    }
  }
  
  private func checkCharacterData() {
    
    let characterDataList = LocalDataManager.shared.fetchAll(CharacterEntity.self,
                                                             context: self.modelContext)
      .filter { HouseEntity.from(houseName: $0.houseName)?.name == self.dataEntity.houseSelected?.name }
    
    if characterDataList.isEmpty {
      self.worker.fetchCharacterList()
      return
    }
    
    self.dataEntity.characterDataList = characterDataList
    self.presenter?.onUpdateData(data: self.dataEntity)
  }
  
  // MARK: Public Methods
  
}

// MARK: - PresenterToInteractorProtocol Methods

extension HomeInteractor: HomePresenterToInteractorProtocol {
  
  func onModuleLoad() {}
  
  func onModuleRefresh() {
    checkHouseData()
    checkCharacterData()
  }
  
  func onHouseSelected(house: HouseSliderViewEntity) {
    dataEntity.houseSelected = dataEntity.houseDataList.first(where: {
      $0.name.lowercased() == house.name.lowercased()
    })
    checkCharacterData()
  }
}

// MARK: - WorkerToInteractorProtocol Methods

extension HomeInteractor: HomeWorkerToInteractorProtocol {
  
  func onFetchCharacterListSuccess(dataList: [CharacterEntityDTO]) {
    onFetchCharacterDataList(dataList: dataList)
  }
  
  func onFetchCharacterListFail(error: APIError) {
    presenter?.onFetchCharacterListFail(errorMsg: error.errorDescription)
  }
}
