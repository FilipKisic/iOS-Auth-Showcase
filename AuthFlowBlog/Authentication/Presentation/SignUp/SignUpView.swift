//
//  SignUpScene.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 14.10.2024.
//

import SwiftUI

struct SignUpView: View {
  // MARK: - PROPERTIES
  @EnvironmentObject private var router: Router
  @EnvironmentObject private var viewModel: SignUpViewModel
  
  // MARK: - BODY
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      VStack(alignment: .leading) {
        renderHeader()
        
        Spacer()
          .frame(height: 20)
        
        renderFields()
        
        Spacer()
          .frame(height: 30)
        
        renderButton()
        
        Spacer()
        
        renderFooter()
    
      } //: VSTACK
      .padding(.vertical, 50)
      .padding(.horizontal, 20)
      
      Image("RunningMan")
        .resizable()
        .scaledToFit()
        .frame(width: 256)
    } //: ZSTACK
    .onChange(of: viewModel.state.isAuthenticated, perform: handleStateChange)
    .ignoresSafeArea(.all)
  }
  
  func handleStateChange(isAuthenticated: Bool) {
    if isAuthenticated { router.navigateTo(.home) }
  }
}

private extension SignUpView {
  @ViewBuilder
  func renderHeader() -> some View {
    HStack {
      Spacer()
      Image("ReplyLogo")
        .resizable()
        .scaledToFit()
        .frame(width: 220)
      Spacer()
    } //: HSTACK
    .padding(.vertical, 40)
    Text("Hello, welcome!")
      .font(.custom("Lato-Bold", size: 22))
  }
  
  @ViewBuilder
  func renderFields() -> some View {
    VStack(alignment: .leading) {
      CustomTextFieldView("Email", $viewModel.state.email, type: .email)
      
      Spacer()
        .frame(height: 10)
      
      CustomTextFieldView("Username", $viewModel.state.username, type: .text)
      
      Spacer()
        .frame(height: 10)
      
      CustomTextFieldView("Password", $viewModel.state.password, type: .password)
    }
  }
  
  @ViewBuilder
  func renderButton() -> some View {
    CustomButtonView(
      label: "Sign up",
      isLoading: $viewModel.state.isLoading,
      function: { viewModel.signUp() }
    )
  }
  
  @ViewBuilder
  func renderFooter() -> some View {
    HStack {
      Spacer()
      
      Text("Already have an account?")
        .font(.custom("Lato-Regular", size: 14))
      
      Text("Sign in.")
        .font(.custom("Lato-Bold", size: 14))
        .foregroundColor(.branding)
        .onTapGesture {
          router.navigateBack()
        }
      
      Spacer()
    } //: HSTACK
  }
}

// MARK: - PREVIEW
#Preview {
  SignUpView()
}
