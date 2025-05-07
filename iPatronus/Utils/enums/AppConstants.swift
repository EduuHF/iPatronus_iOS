//
//  AppConstants.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 06/05/25.
//

import Foundation

enum AppConstants {
  
  // MARK: UserDefauls
  
  enum UserDefaultsKeys {
    static let userDataKey = "user_data_key"
  }
  
  // MARK: Firebase
  
  enum FirebaseKeys {
    static let usersBDKey = "users"
    static let favCharactersBDKey = "favoriteCharacters"
  }
  
  // MARK: Regex
  
  enum RegexKeys {
    static let validEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let validPass = "^(?=.*[A-Za-z])(?=.*\\d).{6,}$"
  }
}
