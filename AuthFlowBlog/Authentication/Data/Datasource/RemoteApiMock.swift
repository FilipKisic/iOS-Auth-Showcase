//
//  RemoteApiMock.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

import Foundation

class RemoteApiMock {
  private var userDatabase = [
    User(email: "user@mail.com", password: "Pa$$w0rd", username: "John", token: "John123"),
    User(email: "other@mail.com", password: "L0z!nk@123", username: "Joey", token: "Joey123"),
  ]
  
  func signIn(email: String, password: String) async throws -> Data {
    let user = userDatabase.first(where: { $0.email == email && $0.password == password })
    
    try await Task.sleep(nanoseconds: 2_000_000_000)
    
    if user == nil {
      let error = AuthError(code: 404, message: "Invalid username or password")
      throw error
    }
    
    
    let json = try JSONEncoder().encode(user!)
    return json
  }
  
  func signUp(email: String, username: String, password: String) async throws -> Data {
    let potentialUser = userDatabase.first(where: { $0.email == email || $0.username == username})
    
    try await Task.sleep(nanoseconds: 2_000_000_000)
    
    if potentialUser != nil {
      let error = AuthError(code: 400, message: "User already exists")
      throw error
    }
    
    let newUser = User(
      email: email,
      password: password,
      username: username,
      token: "\(username)123"
    )
    
    userDatabase.append(newUser)
    
    let json = try JSONEncoder().encode(newUser)
    return json
  }
}
