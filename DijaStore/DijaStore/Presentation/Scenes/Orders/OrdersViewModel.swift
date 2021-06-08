//
//  OrdersViewModel.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Combine

class OrdersViewModel: OrdersViewModelProtocol {
    struct Callbacks {
        let showDetails: (Order) -> Void
        let handleError: (AppError, _ retryAction: @escaping () -> Void) -> Void
    }

    @Published private var orders: [Order] = []

    private let dependencies: OrdersInteractorProvider
    private let callbacks: Callbacks
    private var cancellables = Set<AnyCancellable>()

    init(
        dependencies: OrdersInteractorProvider,
        callbacks: Callbacks
    ) {
        self.dependencies = dependencies
        self.callbacks = callbacks
    }

    var ordersPublisher: AnyPublisher<[Order], Never> {
        return $orders.eraseToAnyPublisher()
    }

    func fetch() {
        dependencies.orders
            .fetchOrders()
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard case .failure(let error) = completion else { return }
                    self?.callbacks.handleError(error) {
                        self?.fetch()
                    }
                },
                receiveValue: { [weak self] orders in
                    self?.orders = orders
                }
            )
            .store(in: &cancellables)
    }

    func selectOrder(at index: Int) {
        guard index < orders.count else { return }
        callbacks.showDetails(orders[index])
    }
}
