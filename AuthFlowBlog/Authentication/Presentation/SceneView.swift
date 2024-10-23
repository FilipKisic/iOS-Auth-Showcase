//
//  SceneView.swift
//  AuthFlowBlog
//
//  Created by Iris Veronika Celic on 23/10/2024.
//

import SwiftUI

// MARK: - SceneView

@MainActor
public protocol SceneView: View {
    associatedtype ViewModel: ViewModelType

    var viewModel: ViewModel { get }
}

// MARK: State

public extension SceneView {
    var state: ViewModel.State {
        viewModel.state
    }
}
