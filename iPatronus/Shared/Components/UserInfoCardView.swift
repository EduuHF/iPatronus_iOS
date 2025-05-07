//
//  UserInfoCardView.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 06/05/25.
//

import Foundation
import SwiftUI

struct UserInfoCardView: View {
  
  // MARK: Properties and Vars
  
  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    
    ZStack(alignment: .topLeading) {
      
      // BG Rectangle
      RoundedRectangle(cornerRadius: 10)
        .fill(AppColors.colorBlack)
        .shadow(radius: 8)
        .frame(height: 130)
      
      VStack(alignment: .leading) {
        
        HStack {
          
          // Name and Email
          Text(SessionManager.shared.userData?.name ?? "Eduardo Herrera")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(AppColors.colorSilver)
            .padding(.top, 20)
          
          Spacer()
          
          // IMG
          IMGView(imagePath: SessionManager.shared.userData?.imagePath ?? "")
            .frame(width: 120, height: 120)
            .background(AppColors.colorBlack)
            .clipShape(Circle())
            .overlay(Circle().stroke(AppColors.colorSilver, lineWidth: 4))
            .shadow(radius: 4)
            .offset(y: -30)
        }
        .frame(height: 60)
        .padding(.horizontal)
        .padding(.top, 20)
        
        Text(SessionManager.shared.userData?.email ?? "systemeduh@gmail.com")
          .font(.headline)
          .foregroundStyle(AppColors.colorSilver)
          .padding(.horizontal)
      }
    }
    .padding(.horizontal)

  }
  
  // MARK: Private Methods
  
  // MARK: Public Methods
  
}

// MARK: Extension Methods

// MARK: Preview Methods
