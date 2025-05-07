//
//  CharacterGripView.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 01/05/25.
//

import Foundation
import SwiftUI

// MARK: Grip View

struct CharacterGripView: View {
  
  // MARK: Properties and Vars
  
  private let columns = [
    GridItem(.flexible(), spacing: 20),
    GridItem(.flexible(), spacing: 20)
  ]
  var characterList: [CharacterGripViewEntity] = []
  var characterGripBGColor: Color = AppColors.colorBlue
  var onCharacterTap: (CharacterGripViewEntity) -> Void
  
  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 20) {
        ForEach(characterList) { item in
          if item.isLoading {
            EmptyLoadingCardView()
          } else {
            CharacterGripCardView(characterItem: item,
                                  characterBGColor: characterGripBGColor) {
              onCharacterTap(item)
            }
          }
        }
      }
      .padding()
    }
  }
}

private struct EmptyLoadingCardView: View {
  var body: some View {
    Rectangle()
      .frame(height: 200)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .shimmer()
  }
}

// MARK: Grip Card

private struct CharacterGripCardView: View {
  
  @State private var isVisible: Bool = false
  let characterItem: CharacterGripViewEntity
  var characterBGColor: Color = AppColors.colorBlue
  var onTap: () -> Void
  
  var body: some View {
    ZStack(alignment: .bottom) {
      
      // IMG
      IMGView(imagePath: characterItem.imagePath ?? "")
      
      LinearGradient(
        gradient: Gradient(colors: [.clear, .black.opacity(0.9)]),
        startPoint: .center,
        endPoint: .bottom
      )
      .overlay(
        Text(characterItem.name ?? "")
          .font(.headline)
          .foregroundStyle(Color.white)
          .padding(.horizontal, 20)
          .padding(.bottom, 10),
        alignment: .bottomLeading
      )
    }
    .frame(height: 200)
    .clipShape(RoundedRectangle(cornerRadius: 10))
    .shadow(radius: 4)
    .opacity(isVisible ? 1 : 0)
    .scaleEffect(isVisible ? 1 : 0.95)
    .background(
      RoundedRectangle(cornerRadius: 10)
          .fill(characterBGColor)
    )
    .onTapGesture {
      if !characterItem.isLoading {
        onTap()
      }
    }
    .onAppear {
      withAnimation(.easeOut(duration: 0.5)) {
        isVisible = true
      }
    }
    .onDisappear {
      isVisible = false
    }
  }
}

