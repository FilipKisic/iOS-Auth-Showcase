//
//  SignUpUseCase.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

class SignUpUseCase {
  private var repository: AuthenticationRepositoryType
  
  init(_ repository: AuthenticationRepositoryType) {
    self.repository = repository
  }
  
  func execute(email: String, username: String, password: String) async -> Result<User, AuthenticationException> {
    return await UseCase.use(repository.signUp)
      .input((email: email, username: username, password: password))
      .output(User.self)
      .canThrow(AuthenticationException.self)
      .execute()
  }
}
