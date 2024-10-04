//
//  SignInSceneViewModel.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

import SwiftUI
import Dependency

final class SignInSceneViewModel: ObservableObject {
  // MARK: - PROPERTIES
  @Dependency(\.signInUseCase) private var signInUseCase: SignInUseCase
  
  @Published var state: SignInSceneState
  
  // MARK: - CONSTRUCTOR
  init() {
    self.state = SignInSceneState()
  }
  
  // MARK: - FUNCTIONS
  func signIn() async {
    state.isLoading = true
    state.isEmailInvalid = false
    state.doesPasswordObeyPolicy = true
    
    if (!isEmail(state.email)) {
      state.isLoading = false
      state.isEmailInvalid = true
    }
    
    if (state.password.isEmpty) {
      state.isLoading = false
      state.isPasswordEmpty = true
    }
    
    guard !state.isEmailInvalid, state.isPasswordEmpty else {
      return
    }
    
    let result = await signInUseCase.execute(email: state.email, password: state.password)
    
    state.isLoading = false
    
    switch result {
      case .success(let user):
        state.isEmailInvalid = false
        state.isPasswordEmpty = false
        state.doesPasswordObeyPolicy = true
        state.errorMessage = ""
      case .failure(let error):
        switch error {
          case .invalidEmailOrPassword(let message),
              .unknownException(let message),
              .userAlreadyExists(let message):
            state.errorMessage = message
        }
    }
  }
  
  
  private func isEmail(_ potentialEmail: String) -> Bool {
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: potentialEmail)
  }
}

//TODO: What about setting the user in the app context, create generic AuthContext or AppContext struct? Nothing will be cached except the Token which will be stored in the Keychain
