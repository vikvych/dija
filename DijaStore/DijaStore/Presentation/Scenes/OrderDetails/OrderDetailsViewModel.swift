//
//  OrderDetailsViewModel.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Combine

class OrderDetailsViewModel: OrderDetailsViewModelProtocol {
    struct Callbacks {
        let handleError: (AppError, _ retryAction: @escaping () -> Void) -> Void
    }

    @Published private var order: Order

    private let dependencies: OrdersInteractorProvider
    private let callbacks: Callbacks
    private var cancellables = Set<AnyCancellable>()

    init(
        order: Order,
        dependencies: OrdersInteractorProvider,
        callbacks: Callbacks
    ) {
        self.order = order
        self.dependencies = dependencies
        self.callbacks = callbacks
    }

    var titlePublisher: AnyPublisher<String, Never> {
        return $order
            .map { order in "\(order.orderDisplayId) · \(order.storeName)" }
            .eraseToAnyPublisher()
    }

    var detailsPublisher: AnyPublisher<[OrderDetailsItem], Never> {
        return $order
            .map { order in
                var details = [
                    OrderDetailsItem(info: .orderDetails(order))
                ]

                if let notes = order.deliveryNotes, !notes.isEmpty {
                    details += [
                        .init(info: .deliveryNotes(notes))
                    ]
                }

                if let lineItems = order.lineItems {
                    details += lineItems.map { item in
                        .init(info: .lineItem(item))
                    }
                }

                return details
            }
            .eraseToAnyPublisher()
    }



    func fetch() {
        dependencies.orders
            .fetchOrderDetails(with: order.id)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard case .failure(let error) = completion else { return }
                    self?.callbacks.handleError(error) {
                        self?.fetch()
                    }
                },
                receiveValue: { [weak self] order in
                    self?.order = order
                }
            )
            .store(in: &cancellables)
    }
}
