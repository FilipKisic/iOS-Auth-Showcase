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
    VStack(alignment: .leading) {
      renderHeader()
      
      Spacer()
        .frame(height: 100)
      
      renderFields()
      
      Spacer()
      
      renderButton()
    } //: VSTACK
    .padding()
    .scrollDismissesKeyboard(.immediately)
  }
  
  // MARK: - FUNCTIONS
  private func handleStateChange(_ state: SignInSceneState) {
    print("isEmailInvalid: \(state.isEmailInvalid)")
    print("isLoading: \(state.isLoading)")
    print("isPasswordEmpty: \(state.isPasswordEmpty)")
    print("errorMessage: \(state.errorMessage)")
    print("------------------------------------------")
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
    Text("Welcome!")
      .font(.title)
      .fontWeight(.bold)
      .fontDesign(.rounded)
    Text("Please enter your credentials to proceed.")
      .font(.subheadline)
      .fontDesign(.rounded)
  }
  
  @ViewBuilder
  func renderFields() -> some View {
      TextField("Email", text: $viewModel.state.email)
      .modifier(CustomInputFieldModifier())
      .fontDesign(.rounded)
    
    Spacer()
      .frame(height: 15)
    
      SecureField("Password", text: $viewModel.state.password)
      .textContentType(.password)
      .modifier(CustomInputFieldModifier())
      .fontDesign(.rounded)
  }
  
  @ViewBuilder
  func renderButton() -> some View {
    Button {
        viewModel.handle(.signIn)
    } label: {
      Text("Sign in")
        .frame(maxWidth: .infinity)
        .padding(15)
        .foregroundStyle(Color.white)
        .fontDesign(.rounded)
        .fontWeight(.bold)
    }
    .background(Color.blue)
    .cornerRadius(7)
  }
}


// MARK: - INPUT MODIFIER
private struct CustomInputFieldModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 7)
          .stroke(Color.gray, lineWidth: 1)
      )
      .autocorrectionDisabled()
      .textInputAutocapitalization(.never)
  }
}

// MARK: - PREVIEW
#Preview {
  var viewModel = SignInSceneViewModel()
  return SignInScene(viewModel: viewModel)
}
