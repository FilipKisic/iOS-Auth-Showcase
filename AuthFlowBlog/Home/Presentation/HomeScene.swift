//
//  HomeScene.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 08.10.2024..
//

import SwiftUI

struct HomeScene: View {
  @StateObject var  viewModel: HomeSceneViewModel = .init()
  
  var body: some View {
    Text("Hello, \(viewModel.userEmail)")
      .navigationBarBackButtonHidden()
  }
}

#Preview {
  HomeScene()
}
