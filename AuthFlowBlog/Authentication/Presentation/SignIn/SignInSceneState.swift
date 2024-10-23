//
//  SignInSceneState.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

struct SignInSceneState {
  var email: String = ""
  var password: String = ""
  var isLoading: Bool = false
  
  var isEmailInvalid: Bool = false
  var isPasswordEmpty: Bool = false
  var doesPasswordObeyPolicy: Bool = true
  
  var errorMessage: String = ""
}
