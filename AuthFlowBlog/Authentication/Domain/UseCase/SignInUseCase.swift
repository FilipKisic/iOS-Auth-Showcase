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
    return await UseCase.use(repository.signIn)
      .input((email, password))
      .output(User.self)
      .canThrow(AuthenticationException.self)
      .execute()
  }
}
