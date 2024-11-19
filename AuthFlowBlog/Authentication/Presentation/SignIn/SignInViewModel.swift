//
//  SignInSceneViewModel.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

import SwiftUI
import Dependency

final class SignInViewModel: ObservableObject {
  // MARK: - PROPERTIES
  @Dependency(\.signInUseCase) private var signInUseCase: SignInUseCase
  
  @KeychainStorage("userToken") private var userToken: String
  @KeychainStorage("userEmail") private var userEmail: String
  
  @Published var state: SignInState
  
  // MARK: - CONSTRUCTOR
  init (state: SignInState = SignInState()) {
    self.state = state
  }
  
  // MARK: - FUNCTIONS
  @MainActor
  func signIn() {
    state.isLoading = true
    
    let isInputInvalid = state.email.validateAsEmail() != nil || state.password.isEmpty || state.password.validateAsPassword() != nil
    
    if isInputInvalid {
      state.isLoading = false
      return
    }
    
    Task {
      let result = await signInUseCase.execute(email: state.email, password: state.password)
      
      state.isLoading = false
      
      switch result {
        case .success(let user):
          state.errorMessage = ""
          state.isErrorVisible = false
          
          userToken = user.token
          userEmail = user.email
          
          state.isAuthenticated = true
        case .failure(let error):
          switch error {
            case .invalidEmailOrPassword(let message),
                .userAlreadyExists(let message),
                .unknown(let message):
              state.errorMessage = message
              state.isErrorVisible = true
          }
          state.isAuthenticated = false
      }
    }
  }
}
