//
//  CustomButtonView.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 14.10.2024..
//

import SwiftUI

struct CustomButtonView: View {
  // MARK: - PROPERTIES
  let label: String
  @Binding var isLoading: Bool
  let function: () -> Void
  
  // MARK: - BODY
  var body: some View {
    Button {
      function()
    } label: {
      if isLoading {
        ProgressView()
          .progressViewStyle(.circular)
          .tint(.white)
          .scaleEffect(1.2)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 15)
      } else {
        Text(label)
          .frame(maxWidth: .infinity)
          .padding(15)
          .foregroundStyle(Color.white)
          .font(.custom("Lato-Black", size: 16))
      }
    }
    .background(.branding)
    .cornerRadius(5)
    .shadow(color: .gray.opacity(0.25), radius: 5, x: 0, y: 5)
  }
}

// MARK: - PREVIEW
#Preview {
  @Previewable @State var isLoading: Bool = false
  CustomButtonView(label: "Sign in",  isLoading: $isLoading , function: {})
    .padding()
}
