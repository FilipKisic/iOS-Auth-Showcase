//
//  SignInScene.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

import SwiftUI

struct SignInScene<ViewModel: ViewModelType>: SceneView where ViewModel.State == SignInSceneState, ViewModel.Action == SignInSceneAction
{
  // MARK: - PROPERTIES
  @StateObject var viewModel: ViewModel
  @FocusState private var focusedField: FocusedField?
  
  // MARK: - BODY
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
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
      
      Image("RunningMan")
        .resizable()
        .scaledToFit()
        .frame(width: 256)
    } //: ZSTACK
    .ignoresSafeArea(.all)
  }
}

// MARK: - ENUM
private enum FocusedField {
  case email
  case password
}

private extension SignInScene {
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
    CustomTextFieldView("Email", $viewModel.state.email)
    
    Spacer()
      .frame(height: 20)
    
    CustomTextFieldView("Password", $viewModel.state.password, isPassword: true)
  }
  
  @ViewBuilder
  func renderButton() -> some View {
    CustomButtonView(
      isLoading: $viewModel.state.isLoading,
      function: { viewModel.handle(.signIn) }
    )
  }
  
  @ViewBuilder
  func renderFooter() -> some View {
    HStack {
      Spacer()
      
      Text("Don't have an account?")
        .font(.custom("Lato-Regular", size: 14))
      
      Text("Sign up.")
        .font(.custom("Lato-Bold", size: 14))
        .foregroundColor(.branding)
        .onTapGesture {
          //redirect to sign up
        }
      
      Spacer()
    } //: HSTACK
  }
}

// MARK: - PREVIEW
#Preview {
  var viewModel = SignInSceneViewModel()
  return SignInScene(viewModel: viewModel)
}
