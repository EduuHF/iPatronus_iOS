//
//  TabBar.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 26/04/25.
//

import SwiftUI

struct TabBar: View {
  
  // MARK: Properties and Vars
  
  @Binding var selectedTab: TabItem
  
  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    VStack {
      Spacer()
      HStack(spacing: 20) {
        ForEach(TabItem.allCases, id: \.self) { tab in
          Button(action: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
              selectedTab = tab
            }
          }) {
            HStack(spacing: 8) {
              Image(tab.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundStyle(selectedTab == tab ? AppColors.colorSilver : AppColors.colorGreen)
              
              if selectedTab == tab {
                Text(tab.title)
                  .foregroundStyle(AppColors.colorSilver)
                  .font(.system(size: 16, weight: .semibold))
                  .transition(.opacity.combined(with: .move(edge: .trailing)))
              }
            }
            .padding(.horizontal, selectedTab == tab ? 16 : 0)
            .padding(.vertical, 10)
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 10)
      .background(
        RoundedRectangle(cornerRadius: 30)
          .fill(AppColors.colorBlue)
          .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
      )
      .padding(.horizontal, 40)
      .padding(.bottom, 10)
    }
  }
}

// MARK: TabBar Item

enum TabItem: CaseIterable {
  
  case home, search, profile
  
  var iconName: String {
    switch self {
    case .home:
      return "home-ic"
    case .search:
      return "search-ic"
    case .profile:
      return "profile-ic"
    }
  }
  
  var title: String {
    switch self {
    case .home:
      return "Home"
    case .search:
      return "Search"
    case .profile:
      return "Profile"
    }
  }
}

#Preview {
  TabBar(selectedTab: .constant(.home))
}
