//
//  AuthenticationRepositoryImpl.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 11.11.2024..
//
import Foundation

class AuthenticationRepositoryImpl: AuthenticationRepositoryType {
  private let api: RemoteApiMock
  
  init(api: RemoteApiMock) {
    self.api = api
  }
  
  func signIn(email: String, password: String) async throws -> User {
    do {
      let json = try await api.signIn(email: email, password: password)
      let user = try JSONDecoder().decode(User.self, from: json)
      return user
    } catch let error as AuthError {
      if error.message == "Invalid email or password" {
        throw AuthenticationException.invalidEmailOrPassword(error.message)
      }
      throw AuthenticationException.unknown(error.message)
    }
  }
  
  func signUp(email: String, username: String, password: String) async throws -> User {
    do {
      let json = try await api.signUp(email: email, username: username, password: password)
      let user = try JSONDecoder().decode(User.self, from: json)
      return user
    } catch let error as AuthError {
      if error.message == "User already exists" {
        throw AuthenticationException.userAlreadyExists(error.message)
      }
      throw AuthenticationException.unknown(error.message)
    }
  }
}
