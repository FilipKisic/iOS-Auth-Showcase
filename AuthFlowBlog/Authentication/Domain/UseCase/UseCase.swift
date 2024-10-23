//
//  UseCase.swift
//  AuthFlowBlog
//
//  Created by Filip Kisić on 07.10.2024..
//

class UseCase<Input, Output, Failure: Error> {
  private var useFunction: ((Input) async throws -> Output)?
  private var input: Input?
  private var outputType: Output.Type?
  private var failure: Failure.Type?
  
  static func use(_ function: @escaping (Input) async throws -> Output) -> UseCase {
    let useCase = UseCase<Input, Output, Failure>()
    useCase.useFunction = function
    return useCase
  }
  
  func input(_ input: Input) -> UseCase {
    self.input = input
    return self
  }
  
  func output(_ type: Output.Type) -> UseCase {
    self.outputType = type
    return self
  }
  
  func canThrow(_ type: Failure.Type) -> UseCase {
    self.failure = type
    return self
  }
  
  func execute() async -> Result<Output, Failure> {
    guard let input = input, let useFunction = useFunction else {
      preconditionFailure("Use case is not configured properly.")
    }
    
    do {
      let result = try await useFunction(input)
      return .success(result)
    } catch let error as Failure {
      return .failure(error)
    } catch {
      preconditionFailure("Use case threw unexpected error: \(error).")
    }
  }
}
