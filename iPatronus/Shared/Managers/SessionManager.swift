//
//  SessionManager.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 06/05/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class SessionManager {
  
  // MARK: Shared Instance
  static let shared = SessionManager()
  
  // MARK: Properties and Vars
  
  var userIsLoggedIn: Bool {
    userData != nil
  }
  
  var userData: UserEntity? {
    get {
      LocalDataManager.shared.getFromUD(UserEntity.self,
                                        forKey: AppConstants.UserDefaultsKeys.userDataKey)
    }
    set {
      LocalDataManager.shared.saveToUD(newValue,
                                       forKey: AppConstants.UserDefaultsKeys.userDataKey)
    }
  }
  
  // MARK: Lifecycle Methods
  
  private init() {}
  
  // MARK: Private Methods
  
  private func toggleFavorite(characterID: String) {
    guard let user = userData else { return }
    
    var currentList = user.favCharacterIDList
    if let index = currentList.firstIndex(of: characterID) {
      currentList.remove(at: index)
    } else {
      currentList.append(characterID)
    }
    
    userData?.favCharacterIDList = currentList
    updateFavCharacterList()
  }
  
  // MARK: Firebase BD Methods
  
  private func fetchFavCharacterList() {
    guard let user = userData else { return }
    
    let bdRef = Firestore.firestore()
      .collection(AppConstants.FirebaseKeys.usersBDKey)
      .document(user.uID)
    
    bdRef.getDocument { [weak self] snapshot, error in
      guard let self = self else { return }
      
      if let data = snapshot?.data(),
          let favIDList = data[AppConstants.FirebaseKeys.favCharactersBDKey] as? [String] {
        userData?.favCharacterIDList = favIDList
      }
      
      NotificationCenter.default.post(name: .userFavListUpdateNoti, object: nil)
    }
  }
  
  private func updateFavCharacterList() {
    guard let user = userData else { return }
    
    let bdRef = Firestore.firestore()
      .collection(AppConstants.FirebaseKeys.usersBDKey)
      .document(user.uID)
    
    bdRef.setData([AppConstants.FirebaseKeys.favCharactersBDKey : user.favCharacterIDList],
                  merge: true) { [weak self] error in
      if error == nil {
        self?.fetchFavCharacterList()
      }
    }
  }
  
  // MARK: Public Methods
}

// MARK: Extension Methods

extension SessionManager {
  
  func onFetchFavCharacterList() {
    fetchFavCharacterList()
  }
  
  func onToggleFavorite(characterID: String) {
    toggleFavorite(characterID: characterID)
  }
  
  func logOut() {
    LocalDataManager.shared.deleteFromUD(forKey: AppConstants.UserDefaultsKeys.userDataKey)
  }
}

