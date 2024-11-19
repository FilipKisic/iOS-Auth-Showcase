//
//  HomeScene.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 08.10.2024..
//

import SwiftUI

struct HomeView: View {
  // MARK: - PROPERTIES
  @EnvironmentObject private var router: Router
  @EnvironmentObject private var viewModel: HomeViewModel
  
  // MARK: - BODY
  var body: some View {
    VStack {
      Text("Hello, \(viewModel.userEmail)")
      Text("Your token: \(viewModel.userToken)")
      CustomButtonView(
        label: "Sign out",
        isLoading: .constant(false)
      ) {
        viewModel.signOut()
      }
    } //: VSTACK
    .padding()
    .navigationBarBackButtonHidden()
    .onChange(of: viewModel.userToken) { _ , newValue in
      if newValue.isEmpty {
        router.poptoRoot()
      }
    }
    .onAppear {
      viewModel.loadUserData()
    }
  }
}

// MARK: - PREVIEW
#Preview {
  ZStack {
    HomeView()
  }
  .environmentObject(HomeViewModel())
}
