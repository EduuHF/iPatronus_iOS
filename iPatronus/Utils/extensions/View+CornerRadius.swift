//
//  View+CornerRadius.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 05/05/25.
//

import Foundation
import SwiftUI

extension View {
  func cornerRadius(_ radius: CGFloat,
                    corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius,
                            corners: corners))
  }
}

struct RoundedCorner: Shape {
  var radius: CGFloat
  var corners: UIRectCorner
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius,
                          height: radius)
    )
    return Path(path.cgPath)
  }
}
