//
//  SignInScene.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

import SwiftUI

struct SignInView: View {
  // MARK: - PROPERTIES
  @EnvironmentObject private var router: Router
  @EnvironmentObject private var viewModel: SignInViewModel
  
  @FocusState private var focusedField: FocusedField?
  
  // MARK: - BODY
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      Image("RunningMan")
        .resizable()
        .scaledToFit()
        .frame(width: 256)
      
      VStack(alignment: .leading) {
        renderHeader()
        
        Spacer()
          .frame(height: 30)
        
        renderFields()
        
        Spacer()
          .frame(height: 50)
        
        renderButton()
        
        Spacer()
        
        renderFooter()
      } //: VSTACK
      .padding(.vertical, 50)
      .padding(.horizontal, 20)
      .scrollDismissesKeyboard(.immediately)
    } //: ZSTACK
    .alert(isPresented: $viewModel.state.isErrorVisible) {
      Alert(
        title: Text("There was an error"),
        message: Text(viewModel.state.errorMessage),
        dismissButton: .default(Text("OK"))
      )
    }
    .onChange(of: viewModel.state.isAuthenticated, perform: handleStateChange)
    .ignoresSafeArea(.all)
    .navigationBarBackButtonHidden()
  }
  
  func handleStateChange(isAuthenticated: Bool) {
    if isAuthenticated { router.navigateTo(.home) }
  }
}

// MARK: - ENUM
private enum FocusedField {
  case email
  case password
}

private extension SignInView {
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
    Text("Welcome back!")
      .font(.custom("Lato-Bold", size: 22))
    
    Text("Please enter your credentials to proceed.")
      .font(.custom("Lato-Regular", size: 14))
  }
  
  @ViewBuilder
  func renderFields() -> some View {
    CustomTextFieldView("Email", $viewModel.state.email, type: .email)
    
    Spacer().frame(height: 10)
    
    CustomTextFieldView("Password", $viewModel.state.password, type: .password)
  }
  
  @ViewBuilder
  func renderButton() -> some View {
    CustomButtonView(
      label: "Sign in",
      isLoading: $viewModel.state.isLoading,
      function: { viewModel.signIn() }
    )
  }
  
  @ViewBuilder
  func renderFooter() -> some View {
    HStack(alignment: .center) {
      Spacer()
      
      Text("Don't have an account?")
        .font(.custom("Lato-Regular", size: 14))
      
      Button {
        router.navigateTo(.signUp)
      } label: {
        Text("Sign up.")
          .font(.custom("Lato-Bold", size: 14))
          .foregroundColor(.branding)
      }
      
      Spacer()
    } //: HSTACK
  }
}

// MARK: - PREVIEW
#Preview {
  ZStack {
    return SignInView()
  }
  .environmentObject(SignInViewModel())
}
