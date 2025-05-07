//
//  TopGradientOverlayView.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 03/05/25.
//

import Foundation
import SwiftUI

struct TopGradientOverlayView: View {
  
  var topColor: Color
  var bottomColor: Color = .clear
  var viewHeight: CGFloat = 0
  
  var body: some View {
    
    GeometryReader { reader in
      let topInset = reader.safeAreaInsets.top + UINavigationBar.currentHeight
      LinearGradient(
        gradient: Gradient(colors: [topColor,
                                    topColor.opacity(0.7),
                                    bottomColor]),
        startPoint: .top,
        endPoint: .bottom
      )
      .frame(height: viewHeight)
      .offset(y: topInset + 30)
    }
    .allowsHitTesting(false)
    .ignoresSafeArea()
  }
}
