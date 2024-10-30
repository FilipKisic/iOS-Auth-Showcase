//
//  SceneFactoryType.swift
//  AuthFlowBlog
//
//  Created by Iris Veronika Celic on 23/10/2024.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - SceneFactoryType

@MainActor
protocol SceneFactoryType {
    func view(for scene: Scene) -> UIViewController
}

// MARK: - SceneFactory

struct SceneFactory: SceneFactoryType {
    init() {}

    func view(for scene: Scene) -> UIViewController {
        switch scene {
        case .signIn:
            createSignInScene().hostingController
        }
    }
}

private extension SceneFactory {
    func createSignInScene() -> some View {
        return SignInScene(
            viewModel: SignInSceneViewModel()
        )
    }
}

private extension View {
    var hostingController: UIViewController {
        UIHostingController(rootView: self)
    }
}
