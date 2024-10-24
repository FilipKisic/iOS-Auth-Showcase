//
//  SignUpScene.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 14.10.2024..
//

import SwiftUI

struct SignUpScene: View {
  // MARK: - PROPERTIES
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  
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
    .ignoresSafeArea(.all)
  }
}

private extension SignUpScene {
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
      CustomTextFieldView("Email", $email)
      
      Spacer()
        .frame(height: 20)
      
      CustomTextFieldView("Password", $password)
      
      Spacer()
        .frame(height: 20)
      
      CustomTextFieldView("Confirm password", $confirmPassword)
    }
  }
  
  @ViewBuilder
  func renderButton() -> some View {
    CustomButtonView(isLoading: .constant(false), function: {} )
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
          //redirect to sign up
        }
      
      Spacer()
    } //: HSTACK
  }
}

// MARK: - PREVIEW
#Preview {
  SignUpScene()
}
