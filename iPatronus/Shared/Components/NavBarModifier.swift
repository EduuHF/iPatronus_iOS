//
//  NavBarModifier.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 01/05/25.
//

import SwiftUI

// MARK: NavBarModifier

struct NavBarModifier: ViewModifier {
  
  var navBGColor: Color?
  var navTextColor: Color?
  
  init(navBGColor: Color?, navTextColor: Color?) {
    self.navBGColor = navBGColor
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.backgroundColor = UIColor(navBGColor ?? AppColors.colorBlue)
    appearance.titleTextAttributes = [.foregroundColor: navTextColor ?? .white]
    appearance.largeTitleTextAttributes = [.foregroundColor: navTextColor ?? .white]
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
    }
  }
}

extension View {
  
  func navigationBarColors(navBGColor: Color?,
                       navTextColor: Color?) -> some View {
    self.modifier(NavBarModifier(navBGColor: navBGColor,
                                 navTextColor: navTextColor))
  }
}

