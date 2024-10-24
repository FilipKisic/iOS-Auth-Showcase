//
//  HomeSceneViewModel.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 08.10.2024..
//
import SwiftUI

final class HomeSceneViewModel: ObservableObject {
  @Published var userEmail: String = ""
  
  @KeychainStorage("userEmail") private var cachedMail: String
  
  init() {
    self.userEmail = cachedMail
  }
}
