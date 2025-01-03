//
//  SignUpViewModel.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 14.11.2024..
//
import SwiftUI
import Dependency

final class SignUpViewModel: ObservableObject {
  // MARK: - PROPERTIES
  @Dependency(\.signUpUseCase) private var signUpUseCase: SignUpUseCase
  
  @KeychainStorage("userToken") private var userToken: String
  @KeychainStorage("userEmail") private var userEmail: String
  
  @Published var state: SignUpState
  
  // MARK: - CONSTRUCTOR
  init(state: SignUpState = SignUpState()) {
    self.state = state
    //self.state.isAuthenticated = !userToken.isEmpty
  }
  
  // MARK: - FUNCTIONS
  @MainActor
  func signUp() {
    state.isLoading = true
    
    Task {
      let result = await signUpUseCase.execute(email: state.email, username: state.username, password: state.password)
      
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
