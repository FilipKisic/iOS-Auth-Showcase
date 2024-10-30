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
  let isPassword: Bool
  
  @FocusState private var focusState: Bool
  
  // MARK: - CONSTRUCTOR
  init(_ placeholder: String, _ text: Binding<String>, isPassword: Bool = false) {
    self._text = text
    self.placeholder = placeholder
    self.isPassword = isPassword
  }
  
  // MARK: - BODY
  var body: some View {
    if isPassword {
      SecureField(placeholder, text: $text)
        .modifier(CustomInputFieldModifier(isFocused: $focusState))
        .textContentType(.password)
        .focused($focusState)
    } else {
      TextField(placeholder, text: $text)
        .modifier(CustomInputFieldModifier(isFocused: $focusState))
        .font(.custom("Lato-Regular", size: 16))
        .focused($focusState)
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
