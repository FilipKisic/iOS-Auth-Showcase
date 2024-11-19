//
//  SignInDependecyInjectionContainer.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 26.09.2024..
//

import Dependency

// MARK: - API CLIENT
private struct RemoteApiMockKey: DependencyKey {
  static var currentValue: RemoteApiMock = .init()
}

// MARK: - REPOSITORY
private struct AuthenticationRepositoryTypeKey: DependencyKey {
  @Dependency(\.remoteApi) private static var remoteApi
  
  static var currentValue: AuthenticationRepositoryType = AuthenticationRepositoryImpl(api: remoteApi)
}

// MARK: - USE CASE
private struct SignInUseCaseKey: DependencyKey {
  @Dependency(\.authenticationRepository) private static var repository
  
  static var currentValue = SignInUseCase(repository)
}

private struct SignUpUseCaseKey: DependencyKey {
  @Dependency(\.authenticationRepository) private static var repository
  
  static var currentValue = SignUpUseCase(repository)
}

// MARK: - GETTERS
extension DependencyValues {
  var remoteApi: RemoteApiMock {
    get { Self[RemoteApiMockKey.self] }
    set { Self[RemoteApiMockKey.self] = newValue }
  }
  
  var authenticationRepository: AuthenticationRepositoryType {
    get { Self[AuthenticationRepositoryTypeKey.self] }
    set { Self[AuthenticationRepositoryTypeKey.self] = newValue }
  }
  
  var signInUseCase: SignInUseCase {
    get { Self[SignInUseCaseKey.self] }
    set { Self[SignInUseCaseKey.self] = newValue }
  }
  
  var signUpUseCase: SignUpUseCase {
    get { Self[SignUpUseCaseKey.self ] }
    set { Self[SignUpUseCaseKey.self] = newValue }
  }
}
