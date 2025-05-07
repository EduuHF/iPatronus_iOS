//
// SearchView.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

// MARK: Methods of SearchView

struct SearchView: View {
  
  // MARK: Properties and Vars
  
  @ObservedObject var presenter: SearchPresenter
  @State private var searchTerm: String = ""
  
  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    NavigationStack {
      ZStack(alignment: .top) {
        
        ScrollView(showsIndicators: false) {
          // Character Grip
          if !presenter.viewEntity.characterDataList.isEmpty {
            CharacterGripView(characterList: presenter.viewEntity.characterDataList,
                              characterGripBGColor: AppColors.colorBlue) { characterSelected in
              NotificationCenter.default.post(name: .showCharacterDetailNoti, object: characterSelected)
            }.padding(.top, 20)
          }
        }
        .padding(.top, 0)
        
        if presenter.viewEntity.characterDataList.isEmpty {
            VStack {
              Spacer()
              Text("Oups! We didn't find any characters...")
                .font(AppFonts.regularHPOne(30))
                .foregroundStyle(AppColors.colorSilver)
                .multilineTextAlignment(.center)
                .padding()
              Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
      }
      .background(AppColors.colorBlue)
      .navigationTitle("SEARCH")
      .navigationBarTitleDisplayMode(.large)
    }
    .onAppear {
      updateNavBar()
      presenter.onModuleRefresh()
    }
    .searchable(text: $searchTerm, prompt: "Search Characters by Name or House...")
    .onChange(of: searchTerm) { _, newValue in
      presenter.onSearchCharacter(term: newValue)
    }
  }
  
  // MARK: Private Methods
  
  private func updateNavBar() {
    setNavigationBarColors(navBGColor: AppColors.colorBlue,
                           navTextColor: .white)
  }
  
  // MARK: Public Methods
}

// MARK: Extension Methods
