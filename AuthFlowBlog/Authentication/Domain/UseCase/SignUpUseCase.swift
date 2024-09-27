//
//  SignUpUseCase.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

class SignUpUseCase {
  private var repository: AuthenticationRepositoryType
  
  init(repository: AuthenticationRepositoryType) {
    self.repository = repository
  }
  
  func execute(email: String, username: String, password: String) async -> Result<User, AuthenticationException> {
    do {
      let user = try await repository.singUp(
        email: email,
        username: username,
        password: password
      )
      return .success(user)
    } catch {
      let failure = error as? AuthenticationException ?? AuthenticationException.unknownException("UnknownException")
      return .failure(failure)
    }
  }
}
