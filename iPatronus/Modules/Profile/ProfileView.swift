//
// ProfileView.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

// MARK: Methods of ProfileView

struct ProfileView: View {
  
  // MARK: Properties and Vars
  
  @State private var needShowLogOutAlert: Bool = false
  @ObservedObject var presenter: ProfilePresenter
  

  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    NavigationStack {
      contentView
        .background(AppColors.colorBlue)
        .navigationTitle("PROFILE")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
              needShowLogOutAlert = true
            }) {
              Image(systemName: "rectangle.portrait.and.arrow.right")
                .foregroundStyle(AppColors.colorSilver)
            }
          }
        }
    }
    .onAppear {
      updateNavBar()
      presenter.onModuleRefresh()
    }
    .alert(isPresented: $needShowLogOutAlert) {
      Alert(title: Text("Log Out"),
            message: Text("Are you sure you want to log out?"),
            primaryButton: .cancel(Text("Cancel"), action: {
        needShowLogOutAlert = false
      }), secondaryButton: .destructive(Text("Log Out"), action: {
        needShowLogOutAlert = false
        SessionManager.shared.logOut()
        NotificationCenter.default.post(name: .userDidLogoutNoti, object: nil)
      }))
    }
  }
  
  private var contentView: some View {
    ZStack(alignment: .top) {
      ScrollView(showsIndicators: false) {
        
        // User Info Card
        UserInfoCardView()
          .padding(.top, 60)
        
        VStack(alignment: .center, spacing: 30) {
          HStack(alignment: .center) {
            Text("My Favorite Characters")
              .font(.title2)
              .fontWeight(.bold)
              .foregroundStyle(AppColors.colorSilver)
              .multilineTextAlignment(.leading)
            Spacer()
          }
          .padding(.horizontal, 20)
          .padding(.top, 20)
          
          //Favorite Characters Grip
          if !presenter.viewEntity.favCharacterDataList.isEmpty {
            CharacterGripView(characterList: presenter.viewEntity.favCharacterDataList,
                              characterGripBGColor: AppColors.colorBlue) { characterSelected in
              NotificationCenter.default.post(name: .showCharacterDetailNoti, object: characterSelected)
            }.padding(.top, 20)
          } else {
            Spacer(minLength: 100)
            Text("Oups! Not Favorite Characters yet...")
              .font(AppFonts.regularHPOne(30))
              .foregroundStyle(AppColors.colorGreen)
              .multilineTextAlignment(.center)
              .padding()
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      .padding(.top, 0)
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

// MARK: Preview Methods

