//
// DetailView.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

// MARK: Methods of DetailView

struct DetailView: View {
  
  // MARK: Properties and Vars
  @ObservedObject var presenter: DetailPresenter

  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    contentView
      .onAppear {
        presenter.onModuleRefresh()
      }
  }
  
  private var contentView: some View {
    ZStack(alignment: .topTrailing) {
      ZStack(alignment: .bottom) {
        
        // IMG
        IMGView(imagePath: presenter.viewEntity.characterInfo?.imagePath ?? "")
        
        LinearGradient(
          gradient: Gradient(colors: [.clear, .black.opacity(0.9)]),
          startPoint: .center,
          endPoint: .bottom
        )
        .overlay(
          characterInfoView,
          alignment: .bottomLeading
        )
      }
      .frame(width: 300, height: 450)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .shadow(radius: 4)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(presenter.viewEntity.secondaryColor ?? AppColors.colorBlue)
      )
      .padding(.horizontal)
      
      Button(action: {
        presenter.onFavTap()
      }) {
        Image(systemName: presenter.viewEntity.isFav ? "star.fill" : "star")
          .resizable()
          .scaledToFit()
          .frame(width: 35, height: 35)
          .foregroundStyle(AppColors.colorSilver)
          .padding(.top, 20)
          .padding(.horizontal, 30)
      }
    }
  }
  
  private var characterInfoView: some View {
    VStack(alignment: .leading) {
      Text(presenter.viewEntity.characterInfo?.name ?? "")
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundStyle(Color.white)
        .padding(.horizontal, 20)
        .padding(.bottom, 5)
      
      HStack(alignment: .bottom) {
        Text("From:")
          .font(.title3)
          .fontWeight(.semibold)
          .foregroundStyle(Color.white)
          .padding(.bottom, 5)
        Text(presenter.viewEntity.characterInfo?.houseName ?? "")
          .font(AppFonts.regularHPOne(35))
          .foregroundStyle(presenter.viewEntity.primaryColor ?? AppColors.colorSilver)
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 20)
    }
  }

  // MARK: Private Methods
  
  // MARK: Public Methods
}

// MARK: Extension Methods

// MARK: Preview Methods

