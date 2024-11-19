//
//  CustomTextField.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 14.10.2024..
//

import SwiftUI

struct CustomTextFieldView: View {
  // MARK: - PROPERTIES
  @Binding var text: String
  
  let placeholder: String
  let type: InputType
  
  @FocusState private var focusState: Bool
  @State private var errorMessage: String = ""
  
  // MARK: - CONSTRUCTOR
  init(_ placeholder: String, _ text: Binding<String>, type: InputType = .text) {
    self._text = text
    self.placeholder = placeholder
    self.type = type
  }
  
  // MARK: - BODY
  var body: some View {
    if type == .password {
      SecureField(placeholder, text: $text)
        .modifier(CustomInputFieldModifier(isFocused: $focusState))
        .onChange(of: text, validate)
        .keyboardType(getKeyboardType())
        .textContentType(.password)
        .focused($focusState)
    } else {
      TextField(placeholder, text: $text)
        .modifier(CustomInputFieldModifier(isFocused: $focusState))
        .font(.custom("Lato-Regular", size: 16))
        .focused($focusState)
        .onChange(of: text, validate)
        .keyboardType(getKeyboardType())
        .textContentType(getTextContentType())
    }
    
    Text(errorMessage)
      .font(.system(size: 12, design: .rounded))
      .foregroundStyle(.error)
      .padding(.leading)
  }
  
  // MARK: - FUNCTIONS
  private func validate() {
    switch type {
      case .email:
        errorMessage = text.validateAsEmail() ?? ""
      case .password:
        errorMessage = text.validateAsPassword() ?? ""
      case .text:
        errorMessage = text.isEmpty ? "Field is empty" : ""
    }
  }
  
  private func getKeyboardType() -> UIKeyboardType {
    return switch type {
      case .email:
          .emailAddress
      case .password:
          .asciiCapable
      case .text:
          .default
    }
  }
  
  private func getTextContentType() -> UITextContentType? {
    return switch type {
      case .email:
          .emailAddress
      case .password:
          .password
      default:
        nil
    }
  }
}

// MARK: - INPUT MODIFIER
private struct CustomInputFieldModifier: ViewModifier {
  var isFocused: FocusState<Bool>.Binding
  
  func body(content: Content) -> some View {
    content
      .padding(15)
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(isFocused.wrappedValue ? Color.blue : Color.gray, lineWidth: isFocused.wrappedValue ? 2 : 1)
      )
      .autocorrectionDisabled()
      .textInputAutocapitalization(.never)
  }
}

// MARK: - PREVIEW
#Preview {
  @Previewable @State var inputText: String = ""
  CustomTextFieldView("Email", $inputText)
    .padding()
}

enum InputType {
  case email, password, text
}
