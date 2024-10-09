//
//  RemoteDataSourceType.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

protocol AuthenticationRepositoryType {
  func signIn(email: String, password: String) async throws -> User
  func signUp(email: String, username: String, password: String) async throws -> User
}
