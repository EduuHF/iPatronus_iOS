//
//  SplashView.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 26/04/25.
//

import SwiftUICore

struct SplashView: View {
  
  // MARK: Properties and Vars
  
  @Environment(\.modelContext) private var modelContext
  private var hColor = AppColors.randomHouseColor
  @EnvironmentObject var appRouter: AppRouter
  
  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    ZStack {
      AppColors.colorBlack
        .ignoresSafeArea(.all)
      
      ZStack {
        Text("iPatronus")
          .font(AppFonts.regularHPOne(100))
          .foregroundStyle(hColor)
          .shimmer(.init(tintColor: AppColors.colorSilver.opacity(0.8), highlightColor: hColor))
      }
      .onAppear {
        preLoadHouseData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          appRouter.currentScreen = .main
        }
      }
    }
  }
  
  private func preLoadHouseData() {
    if LocalDataManager.shared.fetchAll(HouseEntity.self, context: modelContext).isEmpty {
      LocalDataManager.shared.saveAll(HouseEntity.houseListMock, context: modelContext)
    }
  }
}
