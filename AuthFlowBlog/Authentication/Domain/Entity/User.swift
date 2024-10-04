//
//  User.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

class User {
  var email: String
  var password: String
  var username: String
  var token: String
  
  init(email: String, password: String, username: String, token: String) {
    self.email = email
    self.password = password
    self.username = username
    self.token = token
  }
}
