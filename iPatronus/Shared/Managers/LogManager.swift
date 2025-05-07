//
//  LogManager.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 07/05/25.
//

import Foundation

class LogManager {
  
  static let shared = LogManager()
  
  func log(_ data: Any) {
    #if DEBUG
    print("iPatronus App Logger 🔍: \(data)")
    #endif
  }
}
