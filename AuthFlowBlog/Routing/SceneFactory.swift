//
//  SceneFactory.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 10.10.2024..
//
import SwiftUI

enum Screen {
  case signIn, signUp, home
}

struct SceneFactory {
  func build(_ screen: Screen) -> some View {
    let signInSceneViewModel = SignInSceneViewModel()
    switch screen {
      case .signIn: return SignInScene(viewModel: signInSceneViewModel)
      case .signUp: return SignUpScene()
      case .home: return HomeScene()
    }
  }
}
