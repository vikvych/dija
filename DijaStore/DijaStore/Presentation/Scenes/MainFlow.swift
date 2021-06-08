//
//  MainFlow.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import UIKit

class MainFlow {
    lazy var rootViewController = makeRootViewController()

    private let dependencies: DependencyContainer

    init(dependencies: DependencyContainer) {
        self.dependencies = dependencies
    }

    func launch() -> UIViewController {
        return rootViewController
    }
}

private extension MainFlow {
    func makeRootViewController() -> UINavigationController {
        return UINavigationController(
            rootViewController: OrdersViewController(
                viewModel: OrdersViewModel(
                    dependencies: dependencies,
                    callbacks: OrdersViewModel.Callbacks(
                        showDetails: showOrderDetails,
                        handleError: handleError
                    )
                )
            )
        )
    }

    func showOrderDetails(with order: Order) {
        let viewController = OrderDetailsViewController(
            viewModel: OrderDetailsViewModel(
                order: order,
                dependencies: dependencies,
                callbacks: .init(handleError: handleError)
            )
        )

        present(UINavigationController(rootViewController: viewController))
    }

    func handleError(
        _ error: AppError,
        retryAction: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: "Ohh!",
            message: "Something went wrong,\nplease try again",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        if let retryAction = retryAction {
            alert.addAction(
                UIAlertAction(title: "Retry", style: .default, handler: { _ in
                    retryAction()
                })
            )
        }

        present(alert)
    }

    func present(_ viewController: UIViewController) {
        rootViewController.topViewController.present(viewController, animated: true, completion: nil)
    }
}

private extension UIViewController {
    var topViewController: UIViewController {
        return presentedViewController ?? self
    }
}
