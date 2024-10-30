//
//  Coordinator.swift
//  AuthFlowBlog
//
//  Created by Iris Veronika Celic on 23/10/2024.
//

import Foundation
import SwiftUI
import UIKit

// MARK: - CoordinatorPresentationStyle

enum CoordinatorPresentationStyle: Hashable {
    case present
    case replace
    case push
}

// MARK: - CoordinatorType

@MainActor
protocol CoordinatorType: AnyObject {
    var topViewController: UIViewController? { get }

    func present(_ scene: Scene, style: CoordinatorPresentationStyle, animated: Bool)
    func dismissCurrentModalViewController()
    func dismissAllModalViewControllers()
    func pop()
}

// MARK: - Coordinator

final class Coordinator: CoordinatorType {
    private let window: UIWindow
    private let sceneFactory: SceneFactoryType

    var topViewController: UIViewController? {
        window.rootViewController?.topViewController
    }

    var currentNavigationViewController: UINavigationController? {
        window.rootViewController?.currentNavigationViewController
    }

    // MARK: Lifecycle

    init(
        window: UIWindow,
        sceneFactory: SceneFactoryType
    ) {
        self.window = window
        self.sceneFactory = sceneFactory
    }

    func start() {
        present(.signIn, style: .replace, animated: false)
    }

    func present(_ scene: Scene, style: CoordinatorPresentationStyle, animated: Bool) {
        let viewController = sceneFactory.view(for: scene)

        switch style {
        case .present:
            presentViewController(viewController, animated: animated)

        case .replace:
            replaceCurrentViewController(viewController, animated: animated)

        case .push:
            pushViewController(
                viewController,
                animated: animated
            )
        }
    }

    func pop() {
        (topViewController as? UINavigationController)?.popToRootViewController(animated: true)
    }

    func dismissCurrentModalViewController() {
        topViewController?.dismiss(animated: true)
    }

    func dismissAllModalViewControllers() {
        window.rootViewController?.dismiss(animated: true)
    }
}

private extension Coordinator {
    func replaceCurrentViewController(_ viewController: UIViewController, animated: Bool) {
        let animation = { [unowned self] in
            window.rootViewController = viewController
        }

        window.setNeedsLayout()
        window.layoutIfNeeded()

        animated
            ? UIView.transition(with: window, duration: 0.5, options: [.transitionCurlUp], animations: animation, completion: nil)
            : animation()
    }

    func presentViewController(_ viewController: UIViewController, animated: Bool) {
        guard let topViewController else {
            return
        }

        viewController.isModalInPresentation = false
        topViewController.present(viewController, animated: animated, completion: nil)
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let currentNavigationViewController else {
            return
        }

        currentNavigationViewController.pushViewController(viewController, animated: animated)
    }
}

private extension UIViewController {
    var topViewController: UIViewController? {
        var topViewController: UIViewController? = self

        if let tabBarController = topViewController as? UITabBarController {
            topViewController = tabBarController.selectedViewController
        }

        while topViewController?.presentedViewController != nil {
            topViewController = topViewController?.presentedViewController
        }

        return topViewController
    }

    var currentNavigationViewController: UINavigationController? {
        var topViewController: UIViewController? = topViewController

        if let navigationController = topViewController as? UINavigationController {
            return navigationController
        }

        var navigationController: UINavigationController?

        while topViewController?.children.first != nil, navigationController == nil {
            navigationController = topViewController?.children.first as? UINavigationController
            topViewController = topViewController?.children.first
        }

        return navigationController
    }
}

