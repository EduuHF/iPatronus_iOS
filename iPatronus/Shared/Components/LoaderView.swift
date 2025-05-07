//
//  LoaderView.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 26/04/25.
//

import SwiftUI
import DotLottie

struct LoaderView: View {
  
  // MARK: Properties and Vars
  
  @EnvironmentObject var loaderManager: LoaderManager
  
  var body: some View {
    ZStack {
      if loaderManager.isLoading {
        Color.black.opacity(0.5)
          .ignoresSafeArea(.all)
        GeometryReader { geometry in
          DotLottieAnimation(fileName: "Loading",
                             config: AnimationConfig(autoplay: true,
                                                     loop: true)).view()
        }
      }
    }
  }
}
