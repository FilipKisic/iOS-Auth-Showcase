//
//  HomeSceneViewModel.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 08.10.2024..
//
import SwiftUI

final class HomeViewModel: ObservableObject {
  // MARK: - PROPERTIES
  @Published var userEmail: String = ""
  @Published var userToken: String = ""
  
  @KeychainStorage("userEmail") private var cachedMail: String
  @KeychainStorage("userToken") private var cachedToken: String
  
  // MARK: - CONSTRUCTOR
  init() {
    self.userEmail = cachedMail
    self.userToken = cachedToken
  }
  
  func loadUserData() {
    userEmail = cachedMail
    userToken = cachedToken
  }
  
  // MARK: - FUNCTIONS
  func signOut() {
    cachedMail = ""
    cachedToken = ""
    userEmail = ""
    userToken = ""
  }
}
