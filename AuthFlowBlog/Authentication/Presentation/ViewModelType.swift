//
//  ViewModelType.swift
//  AuthFlowBlog
//
//  Created by Iris Veronika Celic on 23/10/2024.
//

import Combine
import SwiftUI

// MARK: - ViewModelType

@MainActor
public protocol ViewModelType: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Action

    var state: State { get set }

    func handle(_ action: Action)

    func handle(_ action: Action) async
}

public extension ViewModelType {
    func handle(_ action: Action) {
        Task {
            await handle(action)
        }
    }
}
