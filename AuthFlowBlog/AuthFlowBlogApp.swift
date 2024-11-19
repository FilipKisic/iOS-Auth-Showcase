//
//  AuthFlowBlogApp.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 14.11.2024..
//
import SwiftUI

@main
struct AuthFlowBlogApp: App {
  var body: some Scene {
    WindowGroup {
      MasterRouteView {
        SplashView()
      }
    }
  }
}
