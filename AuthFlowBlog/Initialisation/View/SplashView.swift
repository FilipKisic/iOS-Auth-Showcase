//
//  SplashScene.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 13.11.2024..
//

import SwiftUI

struct SplashView: View {
  // MARK: - PROPERTIES
  @EnvironmentObject private var router: Router
  
  @KeychainStorage("userToken") private var cachedToken: String
  
  // MARK: - BODY
  var body: some View {
    Image("ReplyLogo")
      .resizable()
      .scaledToFit()
      .frame(width: 200)
      .onAppear {
        redirectToNextScene()
      }
  }
  
  func redirectToNextScene() {
    Task {
      try? await Task.sleep(nanoseconds: 1_500_000_000)
      cachedToken.isEmpty ? router.navigateTo(.signIn) : router.navigateTo(.home)
    }
  }
}

#Preview {
  SplashView()
}
