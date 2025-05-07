//
//  LoaderManager.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 26/04/25.
//

import Foundation
import SwiftUI

final class LoaderManager: ObservableObject {
  
  // MARK: Properties and Vars
  
  static let shared = LoaderManager()
  @Published var isLoading: Bool = false
  
  // MARK: Lifecycle Methods
  
  private init() {}
  
  func show() {
    withAnimation {
      self.isLoading = true
    }
  }
  
  func hide() {
    withAnimation {
      self.isLoading = false
    }
  }
}
