//
//  SignInSceneState.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

struct SignInState {
  var email: String = ""
  var password: String = ""
  var isLoading: Bool = false
  
  var errorMessage: String = ""
  var isErrorVisible: Bool = false
  
  var isAuthenticated: Bool = false
}
