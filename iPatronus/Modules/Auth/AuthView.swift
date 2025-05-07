//
// AuthView.swift
//
// Create by Eduardo Herrera
//

import Combine
import SwiftUI

// MARK: Methods of AuthView

struct AuthView: View {
  
  // MARK: Properties and Vars
  
  @State private var email: String = ""
  @State private var pass: String = ""
  @ObservedObject var presenter: AuthPresenter
  @Environment(\.dismiss) private var dismiss
  

  // MARK: Lifecycle Methods and Vars
  
  var body: some View {
    ZStack(alignment: .center) {
      viewContent
      LoaderView()
    }
    .onChange(of: presenter.viewEntity.isUserLoggedIn) { oldValue, newValue in
      if newValue {
        dismiss()
      }
    }
    .alert(isPresented: $presenter.viewEntity.hasError) {
      Alert(title: Text(presenter.viewEntity.errorTitle ?? ""),
            message: Text(presenter.viewEntity.errorMsg ?? ""),
            dismissButton: .default(Text("OK")))
    }
  }

  private var viewContent: some View {
    VStack(spacing: 30) {
      
      Text("iPatronus")
        .font(AppFonts.regularHPTwo(50))
        .foregroundStyle(AppColors.colorSilver)
        .padding(.top, 40)
        
      VStack(spacing: 20) {
        // EMAIL TF
        TextField("Type E-mail", text: $email)
          .keyboardType(.emailAddress)
          .textContentType(.emailAddress)
          .textInputAutocapitalization(.none)
          .padding()
          .background(.white.opacity(0.1))
          .clipShape(
            RoundedRectangle(cornerRadius: 10)
          )
          .foregroundStyle(.white)
        // PASS TF
        SecureField("Type Password", text: $pass)
          .textContentType(.password)
          .textInputAutocapitalization(.none)
          .padding()
          .background(.white.opacity(0.1))
          .clipShape(
            RoundedRectangle(cornerRadius: 10)
          )
          .foregroundStyle(.white)
      }
      .padding(.horizontal, 30)
      
      VStack(spacing: 10) {
        // LOGIN OR SIGN IN BTN
        Button(action: {
          presenter.onUserAuth(email: email, password: pass)
        }) {
          Text("Log in or Sign in")
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColors.colorGreen)
            .clipShape(
              RoundedRectangle(cornerRadius: 10)
            )
        }
   
        // GOOGLE BTN
        Button(action: {
          presenter.onUserAuthWithGoogle()
        }) {
          HStack {
            Spacer()
            Image("Google-IC")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 20, height: 20)
            
            Text("Log in with Google")
              .fontWeight(.bold)
              .padding(.leading, 10)
            Spacer()
          }
          .foregroundStyle(AppColors.colorGreen)
          .padding()
          .frame(maxWidth: .infinity)
          .background(.white)
          .clipShape(
            RoundedRectangle(cornerRadius: 10)
          )
        }
     
      }
      .padding(.top, 30)
      .padding(.horizontal, 30)
      
      Spacer()
    }
    .background(AppColors.colorBlue)
  }

  // MARK: Private Methods
  
  // MARK: Public Methods
}

// MARK: Extension Methods
