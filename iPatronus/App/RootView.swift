//
//  RootView.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 26/04/25.
//

import SwiftUICore

struct RootView: View {
  
  // MARK: Properties and Vars\
  
  @EnvironmentObject var router: AppRouter
  
  // MARK: Lifecycle Methods
  
  var body: some View {
    ZStack {
      switch router.currentScreen {
      case .splash:
        SplashView()
      case .main:
        MainRouter().build()
      }
    }
  }
}

