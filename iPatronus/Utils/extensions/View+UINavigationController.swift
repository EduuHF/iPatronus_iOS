//
//  View+UINavigationController.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 01/05/25.
//

import Foundation
import SwiftUI

extension View {
  
  func setNavigationBarColors(navBGColor: Color?, navTextColor: Color?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
      NotificationCenter.default.post(name: Notification.Name(rawValue: "UPDATE_NAV_BAR_COLORS_NOTI"),
                                      object: nil, userInfo: [
                                        "navBGColor": navBGColor ?? AppColors.colorBlue,
                                        "navTextColor": navTextColor ?? .white
                                      ])
    }
  }
}

extension UINavigationController {
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(updateNavBarColors(noti:)),
                                           name: Notification.Name(rawValue: "UPDATE_NAV_BAR_COLORS_NOTI"),
                                           object: nil)
  }
  
  @objc
  func updateNavBarColors(noti: Notification) {
    guard let info = noti.userInfo else { return }
    let navBGColor = info["navBGColor"] as? Color
    let navTextColor = info["navTextColor"] as? Color
    updateNavBarColors(navBGColor: navBGColor, navTextColor: navTextColor)
  }
  
  private func updateNavBarColors(navBGColor: Color?,
                                  navTextColor: Color?) {
    
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor(navBGColor ?? AppColors.colorBlue)
    navigationBar.standardAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance
    navigationBar.compactAppearance = appearance
    
    navigationBar.standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(navTextColor ?? .white)]
    navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor(navTextColor ?? .white)]
    navigationBar.scrollEdgeAppearance?.largeTitleTextAttributes = [.foregroundColor: UIColor(navTextColor ?? .white)]
    navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor(navTextColor ?? .white)]
    navigationBar.compactAppearance?.largeTitleTextAttributes = [.foregroundColor: UIColor(navTextColor ?? .white)]
    navigationBar.compactAppearance?.titleTextAttributes = [.foregroundColor: UIColor(navTextColor ?? .white)]
  }
}
