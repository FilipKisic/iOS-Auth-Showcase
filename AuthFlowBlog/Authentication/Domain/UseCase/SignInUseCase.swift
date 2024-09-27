//
//  SignInUseCase.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

class SignInUseCase {
  private var repository: AuthenticationRepositoryType
  
  init(_ repository: AuthenticationRepositoryType) {
    self.repository = repository
  }
  
  func execute(email: String, password: String) async -> Result<User, AuthenticationException> {
    do {
      let user = try await repository.singIn(email: email, password: password)
      return .success(user)
    } catch {
      let failure = error as? AuthenticationException ?? AuthenticationException.unknownException("UnknownException")
      return .failure(failure)
    }
  }
}
