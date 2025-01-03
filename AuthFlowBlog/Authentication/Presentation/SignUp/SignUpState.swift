//
//  SignUpState.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 14.11.2024..
//

struct SignUpState {
  var email: String = ""
  var username: String = ""
  var password: String = ""
  var isLoading: Bool = false
  
  var errorMessage: String = ""
  var isErrorVisible: Bool = false
  
  var isAuthenticated: Bool = false
}
