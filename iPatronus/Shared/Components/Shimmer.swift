//
//  Shimmer.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 02/05/25.
//

import Foundation
import SwiftUI

// MARK: Extension for Connect to Views

extension View {
  @ViewBuilder
  func shimmer(_ config: ShimmerConfig = ShimmerConfig(tintColor: .white.opacity(0.5),
                                                       highlightColor: .white,
                                                       blur: 5), canShow: Bool = true) -> some View {
    if canShow {
      self.modifier(ShimmerHelper(config: config))
    }
  }
}

fileprivate struct ShimmerHelper: ViewModifier {
  
  // MARK: Properties and Vars
  
  var config: ShimmerConfig
  @State private var moveTo: CGFloat = -0.7
  
  // MARK: Lifecycle Vars
  
  func body(content: Content) -> some View {
    content
      .hidden()
      .overlay {
        Rectangle()
          .fill(config.tintColor)
          .mask {
            content
          }
          .overlay {
            GeometryReader {
              let size = $0.size
              let extraOffSet = size.height / 2.5
              Rectangle()
                .fill(config.highlightColor)
                .mask {
                  Rectangle()
                    .fill(.linearGradient(colors: [.white.opacity(0),
                                                   config.highlightColor.opacity(config.highlightOpacity),
                                                   .white.opacity(0)],
                                          startPoint: .top,
                                          endPoint: .bottom))
                    .frame(width: size.height * 2)
                    .blur(radius: config.blur)
                    .rotationEffect(.init(degrees: -75))
                    .offset(x: moveTo > 0 ? extraOffSet : -extraOffSet)
                    .offset(x: size.width * moveTo)
                }
            }
            .mask {
              content
            }
          }
          .onAppear {
            DispatchQueue.main.async {
              moveTo = 0.7
            }
          }
          .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
      }
  }
}

// MARK: Shimmer Config

struct ShimmerConfig {
  var tintColor: Color
  var highlightColor: Color
  var blur: CGFloat = 0
  var highlightOpacity: CGFloat = 1
  var speed: CGFloat = 1
}

