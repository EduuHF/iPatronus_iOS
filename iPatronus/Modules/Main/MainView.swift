//
// MainView.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI
import SwiftData

// MARK: Methods of MainView

struct MainView: View {
  
  // MARK: Properties and Vars
  
  @Environment(\.modelContext) private var modelContext
  @State private var selectedTab: TabItem = .home
  @State private var homeModule: AnyView?
  @State private var searchModule: AnyView?
  @State private var profileModule: AnyView?
  @State private var needShowAuthModule: Bool = false
  @State private var selectedCharacter: CharacterGripViewEntity?
  
  @ObservedObject var presenter: MainPresenter
  
  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    
      ZStack{
        switch selectedTab {
        case .home:
          homeModule
        case .search:
          searchModule
        case .profile:
          profileModule
        }
        
        TabBar(selectedTab: $selectedTab)
          .padding(.bottom, 20)
      }
      .onAppear {
        presenter.onModuleLoad()
        
        if homeModule == nil {
          homeModule = AnyView(HomeRouter().build(modelContext: modelContext))
        }
        if searchModule == nil {
          searchModule = AnyView(SearchRouter().build(modelContext: modelContext))
        }
      }
      .onChange(of: selectedTab, { oldValue, newValue in
        if newValue == .profile {
          if SessionManager.shared.userIsLoggedIn {
            if profileModule == nil {
              profileModule = AnyView(ProfileRouter().build(modelContext: modelContext))
            }
          } else {
            needShowAuthModule = true
            selectedTab = oldValue
          }
        }
      })
      .onReceive(NotificationCenter.default.publisher(for: .userDidLogoutNoti)) { _ in
        withAnimation {
          selectedTab = .home
        }
      }
      .onReceive(NotificationCenter.default.publisher(for: .userNeedLogInNoti)) { _ in
        withAnimation {
          selectedCharacter = nil
          needShowAuthModule = true
        }
      }
      .onReceive(NotificationCenter.default.publisher(for: .showCharacterDetailNoti)) { noti in
        if let characterData = noti.object as? CharacterGripViewEntity {
          withAnimation {
            selectedCharacter = characterData
          }
        }
      }
      .sheet(isPresented: $needShowAuthModule) {
        AuthRouter().build()
          .presentationDetents([.height(450)])
          .presentationDragIndicator(.visible)
      }
      .overlay {
        if selectedCharacter != nil {
          characterDetailModule
        }
      }
      .ignoresSafeArea(.all)
    }
  
  // Character Detail 
  private var characterDetailModule: some View {
    ZStack {
      Color.black.opacity(0.7)
        .ignoresSafeArea()
        .onTapGesture {
          withAnimation {
            selectedCharacter = nil
          }
        }
      
      if let characterData = selectedCharacter {
        DetailRouter().build(data: characterData)
          .transition(.scale.combined(with: .opacity))
          .zIndex(1)
      }
    }
    .animation(.easeInOut, value: selectedCharacter)
  }

  // MARK: Private Methods
  
  // MARK: Public Methods
}

