//
//  CoordinatorType.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 10.10.2024..
//

import Foundation
import SwiftUI

// MARK: - PROTOCOL
protocol CoordinatorType: ObservableObject {
  var path: NavigationPath { get set }
  func present(_ screen: Screen)
  func dismiss()
  func replace()
  func backToRoot()
}

// MARK: - IMPLEMENTATION
class Coordinator: CoordinatorType {
  // MARK: - PROPERTIES
  @Published var path: NavigationPath
  
  init(path: NavigationPath = NavigationPath()) {
    self.path = path
  }
  
  // MARK: - FUNCTIONS
  func present(_ screen: Screen) {
    path.append(screen)
  }
  
  func dismiss() {
    path.removeLast()
  }
  
  func replace() {
    //TODO: Implement
  }
  
  func backToRoot() {
    path.removeLast(path.count)
  }
}
