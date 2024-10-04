//
//  RemoteApiMock.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

class RemoteApiMock : AuthenticationRepositoryType {
  private var userDatabase = [
    User(email: "user@mail.com", password: "Pa$$w0rd", username: "John", token: "John123"),
    User(email: "other@mail.com", password: "L0z!nk@", username: "Joey", token: "Joey123"),
  ]
  
  func singIn(email: String, password: String) async throws -> User{
    let user = userDatabase.first(where: { $0.email == email && $0.password == password })
    
    if (user == nil) {
      throw AuthenticationException.invalidEmailOrPassword("Invalid email or password.")
    }
    
    try await Task.sleep(nanoseconds: 2_000_000_000)
    
    return user!
  }
  
  func singUp(email: String, username: String, password: String) async throws -> User {
    let potentialUser = userDatabase.first(where: { $0.email == email || $0.username == username})
    
    if (potentialUser != nil) {
      throw AuthenticationException.userAlreadyExists("User already exists.")
    }
    
    let newUser = User(
      email: email,
      password: password,
      username: username,
      token: "\(username)123"
    )
    
    userDatabase.append(newUser)
    
    try await Task.sleep(nanoseconds: 2_000_000_000)
    
    return newUser
  }
}

enum AuthenticationException: Error {
  case invalidEmailOrPassword(_ message: String)
  case userAlreadyExists(_ message: String)
  case unknownException(_ message: String)
}
