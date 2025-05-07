//
// DetailInteractor.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation

// MARK: Methods of DetailInteractorProtocol

class DetailInteractor: DetailInteractorProtocol {
  
  // MARK: - Properties and Vars

  weak var presenter: DetailInteractorToPresenterProtocol?

  @Published private(set) var dataEntity = DetailInteractorDataEntity()

  // MARK: - Lifecycle Methods

  init(data: CharacterGripViewEntity) {
    dataEntity.characterInfo = data
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(onFavListUpdate),
                                           name: .userFavListUpdateNoti,
                                           object: nil)
  }

  // MARK: Private Methods
  
  private func checkCharacterData() {
    
    dataEntity.characterHouse = .from(houseName: dataEntity.characterInfo?.houseName)
    dataEntity.isFav = false
    
    guard let favList = SessionManager.shared.userData?.favCharacterIDList,
          let characterID = dataEntity.characterInfo?.id.uuidString else {
      self.presenter?.onUpdateData(data: self.dataEntity)
      return
    }
    dataEntity.isFav = favList.contains(where: { $0 == characterID })
    self.presenter?.onUpdateData(data: self.dataEntity)
  }
  
  private func onFavotieTap() {
    guard SessionManager.shared.userIsLoggedIn else {
      NotificationCenter.default.post(name: .userNeedLogInNoti, object: nil)
      return
    }
    guard let favID = dataEntity.characterInfo?.id.uuidString else { return }
    SessionManager.shared.onToggleFavorite(characterID: favID)
  }
  
  @objc private func onFavListUpdate() {
    checkCharacterData()
  }

  // MARK: Public Methods

}

// MARK: - PresenterToInteractorProtocol Methods

extension DetailInteractor: DetailPresenterToInteractorProtocol {
  
  func onFavTap() {
    onFavotieTap()
  }
  
  func onModuleLoad() {}
  func onModuleRefresh() {
    checkCharacterData()
  }
}

