//
//  AppRouter.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 26/04/25.
//

import Foundation

final class AppRouter: ObservableObject {
  
  // MARK: Properties and Vars
  
  enum AppRouterScreen {
    case splash
    case main
  }
  
  @Published var currentScreen: AppRouterScreen = .splash
  
  // MARK: Lifecycle Methods
  
  init(currentScreen: AppRouterScreen) {
    self.currentScreen = currentScreen
  }
}
