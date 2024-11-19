//
//  Router.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 14.11.2024..
//
import Foundation
import SwiftUI

class Router: ObservableObject {
  // MARK: - ALL ROUTES
  enum Route: Hashable {
    case splash
    case signIn
    case signUp
    case home
  }
  
  // MARK: - PROPERTIES
  @Published var path = NavigationPath()
  
  // MARK: - VIEW BUILDER
  @ViewBuilder
  func view(for route: Route) -> some View {
    switch route {
      case .splash: SplashView()
      case .signIn: SignInView()
      case .signUp: SignUpView()
      case .home: HomeView()
    }
  }
  
  // MARK: - FUNCTIONS
  func navigateTo(_ route: Route) {
    path.append(route)
  }
  
  func navigateBack() {
    path.removeLast()
  }
  
  func poptoRoot() {
    path.removeLast(path.count)
  }
}
