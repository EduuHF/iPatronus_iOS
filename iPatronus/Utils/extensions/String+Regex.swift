//
//  String+Regex.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 06/05/25.
//

import Foundation

extension String {
  
  func isValidEmail() -> Bool {
    return NSPredicate(format: "SELF MATCHES %@",
                       AppConstants.RegexKeys.validEmail).evaluate(with: self)
  }
  
  func isValidPass() -> Bool {
    return NSPredicate(format: "SELF MATCHES %@",
                       AppConstants.RegexKeys.validPass).evaluate(with: self)
  }
}
