//
//  HouseSliderView.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 28/04/25.
//

import SwiftUI

// MARK: Card Slider View

struct HouseSliderView<HouseList: RandomAccessCollection>: View where HouseList.Element == HouseSliderViewEntity {
  
  // MARK: Properties and Vars
  @State private var selectedItemID: UUID?
  var selectedHouseID: UUID?
  var houseList: HouseList
  var onHouseSelected: ((HouseSliderViewEntity) -> Void)? = nil
  
  var body: some View {
    VStack(spacing: 20) {
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach(houseList) { item in
            if item.isLoading {
              EmptyLoadingCardView()
            } else {
              HouseCard(houseItem: item)
                .containerRelativeFrame(.horizontal)
                .id(item.id)
            }
          }
        }
        .scrollTargetLayout()
      }
      .scrollIndicators(.hidden)
      .scrollTargetBehavior(.viewAligned)
      .scrollPosition(id: $selectedItemID)
      .onChange(of: selectedItemID, { _, newValue in
        if let id = newValue,
           let selectedItem = houseList.first(where: { $0.id == id }) {
          onHouseSelected?(selectedItem)
        }
      })
      .onAppear {
        DispatchQueue.main.async {
          if selectedItemID == nil {
            selectedItemID = selectedHouseID
          }
        }
      }
    }
    .safeAreaPadding([.horizontal], 20)
  }
}

private struct EmptyLoadingCardView: View {
  var body: some View {
    Rectangle()
      .frame(width: 360, height: 100)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .shimmer()
  }
}

// MARK: Card Slider View

private struct HouseCard: View {
  
  let houseItem: HouseSliderViewEntity
  
  var body: some View {
    HStack(spacing: 20) {
      Image(houseItem.imagePath)
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 100)
        .padding(.leading, 20)
      
      Text(houseItem.name)
        .font(AppFonts.regularHPOne(50))
        .foregroundStyle(houseItem.secondaryColor)
        .multilineTextAlignment(.leading)
        
      Spacer()
    }
    .frame(width: 340, height: 100)
    .padding(.vertical)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(houseItem.primaryColor)
    )
    .clipShape(RoundedRectangle(cornerRadius: 10))
    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
  }
}



