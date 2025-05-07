//
// ProfileInteractor.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation
import SwiftData

// MARK: Methods of ProfileInteractorProtocol

class ProfileInteractor: ProfileInteractorProtocol {
  
  // MARK: - Properties and Vars
  private let modelContext: ModelContext
  weak var presenter: ProfileInteractorToPresenterProtocol?

  @Published private(set) var dataEntity = ProfileInteractorDataEntity()

  // MARK: - Lifecycle Methods

  init(modelContext: ModelContext) {
    self.modelContext = modelContext
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(onFavListUpdate),
                                           name: .userFavListUpdateNoti,
                                           object: nil)
  }

  // MARK: Private Methods
  
  private func checkProfileData() {
    
    guard let favCharacterIDList = SessionManager.shared.userData?.favCharacterIDList else { return }
    var characterDataList = LocalDataManager.shared.fetchAll(CharacterEntity.self,
                                                                   context: self.modelContext)
    
    characterDataList = characterDataList.filter { favCharacterIDList.contains($0.id.uuidString) }
    
    self.dataEntity.favCharacterDataList = characterDataList
    self.presenter?.onUpdateData(data: self.dataEntity)
  }
  
  @objc private func onFavListUpdate() {
    checkProfileData()
  }

  // MARK: Public Methods

}

// MARK: - PresenterToInteractorProtocol Methods

extension ProfileInteractor: ProfilePresenterToInteractorProtocol {
  
  func onModuleLoad() {}
  func onModuleRefresh() {
    checkProfileData()
  }
}

