//
//  StringExtensions.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 13.11.2024..
//
import Foundation

extension String {
  func validateAsEmail() -> String? {
    let isValid = doesMatchRegex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    
    if self.isEmpty {
      return "Email cannot be empty"
    }
    
    if !isValid {
      return "Invalid email address"
    }
    
    return nil
  }
  
  func validateAsPassword() -> String? {
    let isValid = doesMatchRegex("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
    
    if self.isEmpty {
      return "Password cannot be empty"
    }
    
    if self.count < 8 {
      return "Password must be at least 8 characters long"
    }
    
    if !isValid {
      return "Password is too simple"
    }
    
    return nil
  }
  
  private func doesMatchRegex(_ regex: String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: self)
  }
}
