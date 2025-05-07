//
// SearchInteractor.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation
import SwiftData

// MARK: Methods of SearchInteractorProtocol

class SearchInteractor: SearchInteractorProtocol {
  
  // MARK: - Properties and Vars
  
  weak var presenter: SearchInteractorToPresenterProtocol?
  private let modelContext: ModelContext
  
  @Published private(set) var dataEntity = SearchInteractorDataEntity()
  
  // MARK: - Lifecycle Methods
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  // MARK: Private Methods
  
  private func checkAllCharacterData() {
    
    if self.dataEntity.allCharacterList.isEmpty {
      let dataList = LocalDataManager.shared.fetchAll(CharacterEntity.self, context: self.modelContext)
      self.dataEntity.allCharacterList = dataList
      self.dataEntity.filterCharacterList = dataList
    }
  }
  
  private func onMakeSearch(searchTerm: String) {
    
    self.dataEntity.filterCharacterList = self.dataEntity.allCharacterList.filter {
      let search = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
      let name = $0.name?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
      let house = $0.houseName?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
      
      return name.contains(search) || house.contains(search)
    }
    
    self.presenter?.onUpdateData(data: self.dataEntity)
  }
  
  // MARK: Public Methods
  
}

// MARK: - PresenterToInteractorProtocol Methods

extension SearchInteractor: SearchPresenterToInteractorProtocol {
  
  func onModuleLoad() {}
  
  func onModuleRefresh() {
    checkAllCharacterData()
  }
  
  func onSearchCharacter(term: String?) {
    guard let searchTerm = term else { return }
    guard searchTerm.count > 2 else { return }
    onMakeSearch(searchTerm: searchTerm)
  }
  
}
