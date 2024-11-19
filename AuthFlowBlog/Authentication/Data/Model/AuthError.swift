//
//  AuthError.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 11.11.2024..
//

struct AuthError: Error {
  let code: Int
  let message: String
}
