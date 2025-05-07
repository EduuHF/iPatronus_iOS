//
// HomeView.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

// MARK: Methods of HomeView

struct HomeView: View {
  
  // MARK: Properties and Vars
  
  @ObservedObject var presenter: HomePresenter
  
  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    NavigationStack {
      ZStack(alignment: .top) {
        ScrollView(showsIndicators: false) {
          // House Slider
          HouseSliderView(selectedHouseID: presenter.viewEntity.selectedHouseID,
                          houseList: presenter.viewEntity.houseDataList) { houseSelected in
            presenter.onHouseSelected(house: houseSelected)
          }
          .padding(.top, 20)
          
          // Character Grip
          CharacterGripView(characterList: presenter.viewEntity.characterDataList,
                            characterGripBGColor: presenter.viewEntity.primaryColor) { characterSelected in
            NotificationCenter.default.post(name: .showCharacterDetailNoti, object: characterSelected)
          }
        }
        .padding(.top, 0)
      }
      .background(presenter.viewEntity.secondaryColor)
      .navigationTitle("HOME")
      .navigationBarTitleDisplayMode(.large)
    }
    .onAppear {
      presenter.onModuleRefresh()
      updateNavBar()
    }
    .onChange(of: presenter.viewEntity.secondaryColor) { _, _ in
      updateNavBar()
    }
    .onReceive(NotificationCenter.default.publisher(for: .userDidLogoutNoti)) { _ in
      withAnimation {
        updateNavBar()
      }
    }
    .alert(isPresented: $presenter.viewEntity.hasError) {
      Alert(title: Text("Fail"),
            message: Text(presenter.viewEntity.someErrorMgs ?? ""),
            dismissButton: .default(Text("Understand")))
    }
  }

  // MARK: Private Methods
  
  private func updateNavBar() {
    setNavigationBarColors(navBGColor: presenter.viewEntity.secondaryColor,
                           navTextColor: .white)
  }
  
  // MARK: Public Methods
}

// MARK: Extension Methods

