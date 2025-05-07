//
//  IMGView.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 01/05/25.
//

import Foundation

import SwiftUI
import Kingfisher
  
struct IMGView: View {
  
  // MARK: Properties and Vars
  let imagePath: String
  let placeHolderPath: String = "AllHouses-IC"
  
  var body: some View {
    KFImage.url(URL(string: imagePath))
      .placeholder { ImagePlaceholder(imagePath: placeHolderPath) }
      .fade(duration: 0.25)
      .resizable()
      .onFailure { _ in }
      .onSuccess { _ in }
      .clipped()
  }
  
  private struct ImagePlaceholder: View {
    
    let imagePath: String
    var body: some View {
      Image(imagePath)
        .resizable()
        .clipped()
        .aspectRatio(contentMode: .fit)
    }
  }
}
