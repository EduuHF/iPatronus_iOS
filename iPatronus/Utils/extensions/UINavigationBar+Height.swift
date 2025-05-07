//
//  UINavigationBar+Height.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 03/05/25.
//

import Foundation
import UIKit

extension UINavigationBar {
  
  static var currentHeight: CGFloat {
    let root = UIApplication.shared.connectedScenes
      .compactMap { ($0 as? UIWindowScene)?.keyWindow }
      .first?
      .rootViewController
    
    if let nav = findNavController(from: root) {
      return nav.navigationBar.frame.height
    }
    
    return 44 
  }
  
  private static func findNavController(from vc: UIViewController?) -> UINavigationController? {
    if let nav = vc as? UINavigationController {
      return nav
    } else if let tab = vc as? UITabBarController {
      return findNavController(from: tab.selectedViewController)
    } else if let presented = vc?.presentedViewController {
      return findNavController(from: presented)
    } else if let child = vc?.children.first {
      return findNavController(from: child)
    }
    return nil
  }
}
