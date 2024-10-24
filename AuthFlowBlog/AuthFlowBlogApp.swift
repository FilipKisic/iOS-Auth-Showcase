//
//  AuthFlowBlogApp.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

import SwiftUI
import Dependency

@main
struct AuthFlowBlogApp: App {
  // MARK: - PROPERTIES
  @StateObject private var coordinator = Coordinator()
  private let sceneFactory: SceneFactory
  
  // MARK: - CONSTRUCTOR
  init() {
    sceneFactory = SceneFactory()
  }
  
  // MARK: - BODY
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $coordinator.path) {
        sceneFactory.build(.signIn)
          .navigationDestination(for: Screen.self) { screen in
            sceneFactory.build(screen)
          }
      } //: NAVIGATION STACK
      .environmentObject(coordinator)
    }
  }
}
