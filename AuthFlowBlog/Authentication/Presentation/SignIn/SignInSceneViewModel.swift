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
  //@Dependency(\.coordinator) private var coordinator: any CoordinatorType
  
  private let coordinator: any CoordinatorType
  
  @KeychainStorage("userToken") private var userToken: String
  @KeychainStorage("userEmail") private var userEmail: String
  
  @Published var state: SignInSceneState
  
  // MARK: - CONSTRUCTOR
  init (state: SignInSceneState = SignInSceneState(), coordinator: any CoordinatorType) {
    self.state = state
    self.coordinator = coordinator
  }
  
  func handle(_ action: SignInSceneAction) {
    switch action {
      case .signIn:
        signIn()
      case .redirectToSignUp:
        print("Redirect to sign up")
        //coordinator.present(.home)
    }
  }
  
  // MARK: - FUNCTIONS
  private func signIn() {
    state.isLoading = true
    state.isEmailInvalid = false
    
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
          
          userToken = user.token
          userEmail = user.email
          
          coordinator.present(.home)
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
