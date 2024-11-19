//
//  NavigationUtils.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 14.11.2024..
//
import Foundation
import SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}

