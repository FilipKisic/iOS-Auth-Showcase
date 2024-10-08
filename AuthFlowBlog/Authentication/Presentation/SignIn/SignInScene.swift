//
//  SignInScene.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 25.09.2024..
//

import SwiftUI

struct SignInScene: View {
  // MARK: - PROPERTIES
  @StateObject var viewModel: SignInSceneViewModel = .init()
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
    .onChange(of: viewModel.state, perform: handleStateChange)
  }
  
  // MARK: - FUNCTIONS
  private func handleStateChange(_ state: SignInSceneState) {
    print("isEmailValid: \(state.isEmailInvalid)")
    print("isLoading: \(state.isLoading)")
    print("isPasswordEmpty: \(state.isPasswordEmpty)")
    print("errorMessage: \(state.errorMessage)")
  }
}

// MARK: - ENUM
private enum FocusedField {
  case email
  case password
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
    
    TextField("Password", text: $viewModel.state.password)
      .modifier(CustomInputFieldModifier())
      .fontDesign(.rounded)
      .textContentType(.password)
  }
  
  @ViewBuilder
  func renderButton() -> some View {
    Button {
      print("About to sign in")
      Task {
        await viewModel.signIn()
      }
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

// MARK: - PREVIEW
#Preview {
  var viewModel = SignInSceneViewModel()
  return SignInScene(viewModel: viewModel)
}
