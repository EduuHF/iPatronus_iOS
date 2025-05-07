//
// AuthWorker.swift
//
// Create by Eduardo Herrera
//

import Combine
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import Firebase

// MARK: Methods of AuthWorkerProtocol

class AuthWorker: AuthWorkerProtocol {
  
  // MARK: - Properties and Vars

  weak var interactor: AuthWorkerToInteractorProtocol?

  // MARK: - Lifecycle Methods

  init() {}
  
  // MARK: Private Methods
  
  // Login on Firebase
  private func makeLogin(email: String,
                         password: String,
                         completion: @escaping (Result<User, Error>) -> Void) {
    
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if let user = result?.user {
        completion(.success(user))
        return
      } else if let error = error {
        completion(.failure(error))
        return
      } else {
        completion(.failure(APIError.invalidResponse))
        return
      }
    }
  }
  
  // Register on Firebase
  private func makeRegister(email: String,
                            password: String,
                            completion: @escaping (Result<User, Error>) -> Void) {
    
    Auth.auth().createUser(withEmail: email,
                       password: password) { result, error in
      
      guard let result = result else {
        guard let error = error as? NSError else {
          completion(.failure(APIError.invalidResponse))
          return
        }
        guard error.code == AuthErrorCode.emailAlreadyInUse.rawValue else {
          completion(.failure(error))
          return
        }
        self.makeLogin(email: email, password: password, completion: completion)
        return
      }
      completion(.success(result.user))
    }
  }
  
  // Login with Google
  private func makeLoginWithGoogle() {
    guard let clientID = FirebaseApp.app()?.options.clientID else {
      interactor?.onUserAuthFail(error: .invalidFBConfiguration)
      return
    }
    guard let rootVC = UIApplication
      .shared
      .connectedScenes
      .compactMap({ $0 as? UIWindowScene })
      .first?.windows.first?.rootViewController else {
        interactor?.onUserAuthFail(error: .invalidFBConfiguration)
        return
      }
    
    let gConfig = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = gConfig
    
    GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { result, error in
      
      if let error = error {
        self.interactor?.onUserAuthFail(error: .decodingError(error))
        return
      }
      
      guard let user = result?.user,
            let idToken = user.idToken?.tokenString else {
        self.interactor?.onUserAuthFail(error: APIError.invalidResponse)
        return
      }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: user.accessToken.tokenString)
      
      Auth.auth().signIn(with: credential) { authResult, error in
        
        if let error = error {
          self.interactor?.onUserAuthFail(error: .decodingError(error))
          return
        }
        
        guard let user = authResult?.user else {
          self.interactor?.onUserAuthFail(error: .invalidResponse)
          return
        }
        
        self.interactor?.onUserAuthSuccess(user: .init(authUser: user))
      }
    }
  }
}

// MARK: - InteractorToWorkerProtocol Methods

extension AuthWorker: AuthInteractorToWorkerProtocol {
  
  func onUserAuthWithGoogle() {
    makeLoginWithGoogle()
  }
  
  func onUserAuth(email: String, password: String) {
    
    makeRegister(email: email,
                 password: password) { result in
      
      switch result {
      case .success(let userData):
        self.interactor?.onUserAuthSuccess(user: .init(authUser: userData))
      case .failure(let failure):
        self.interactor?.onUserAuthFail(error: APIError.decodingError(failure))
      }
    }
  }
}

