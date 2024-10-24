//
//  SignInDependecyInjectionContainer.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 26.09.2024..
//

import Dependency

// MARK: - REPOSITORY
private struct AuthenticationRepositoryTypeKey: DependencyKey {
  static var currentValue: AuthenticationRepositoryType = RemoteApiMock()
}

// MARK: - USE CASE
private struct SignInUseCaseKey: DependencyKey {
  @Dependency(\.authenticationRepository) private static var repository
  
  static var currentValue = SignInUseCase(repository)
}

private struct CoordinatorKey: DependencyKey {
  static var currentValue: any CoordinatorType = Coordinator()
}

// MARK: - GETTERS
extension DependencyValues {
  var authenticationRepository: AuthenticationRepositoryType {
    get { Self[AuthenticationRepositoryTypeKey.self] }
    set { Self[AuthenticationRepositoryTypeKey.self] = newValue }
  }
  
  var signInUseCase: SignInUseCase {
    get { Self[SignInUseCaseKey.self] }
    set { Self[SignInUseCaseKey.self] = newValue }
  }
  
  var coordinator: any CoordinatorType {
    get { Self[CoordinatorKey.self] }
    set { Self[CoordinatorKey.self] = newValue }
  }
}
