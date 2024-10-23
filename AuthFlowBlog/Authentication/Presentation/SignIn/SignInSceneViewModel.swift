//
//  SignInSceneViewModel.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

import SwiftUI
import Dependency

final class SignInSceneViewModel: ViewModelType {
  // MARK: - PROPERTIES
  @Dependency(\.signInUseCase) private var signInUseCase: SignInUseCase
  
  @Published var state: SignInSceneState

  // MARK: - CONSTRUCTOR
  init (state: SignInSceneState = SignInSceneState()) {
    self.state = state
  }

    func handle(_ action: SignInSceneAction) {
        switch action {
        case .appear:
            return
        case .signIn:
            signIn()
        case .dismiss:
            return
        }
    }

  // MARK: - FUNCTIONS
  @MainActor
  func signIn() {
    state.isLoading = true
    //state.isEmailInvalid = false
    
    if !isEmail(state.email) {
      state.isLoading = false
      state.isEmailInvalid = true
    }
    
    if state.password.isEmpty {
      state.isLoading = false
      state.isPasswordEmpty = true
    }
    
    guard state.isEmailInvalid == false, state.isPasswordEmpty == false else {
      return
    }
    
    Task {
      let result = await signInUseCase.execute(email: state.email, password: state.password)
      
      state.isLoading = false
      
      switch result {
        case .success(let user):
          state.isEmailInvalid = false
          state.isPasswordEmpty = false
          state.doesPasswordObeyPolicy = true
          state.errorMessage = ""
          
          //TODO: Cache token into the Keychain storage
          //TODO: Possible introduction of AuthContext struct where user token will be cached, so no need of constant Keychain fetching
        case .failure(let error):
          switch error {
            case .invalidEmailOrPassword(let message),
                .unknownException(let message),
                .userAlreadyExists(let message):
              state.errorMessage = message
          }
      }
    }
  }
  
  
  private func isEmail(_ potentialEmail: String) -> Bool {
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: potentialEmail)
  }
}

//Nothing will be cached except the Token which will be stored in the Keychain
