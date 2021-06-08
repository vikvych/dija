//
//  OrdersInteractor.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Combine

protocol OrdersRepositoryProtocol {
    func fetchOrders() -> AnyPublisher<[Order], AppError>
    func fetchOrderDetails(with id: Order.ID) -> AnyPublisher<Order, AppError>
}

class OrdersInteractor: OrdersInteractorProtocol {
    private let repository: OrdersRepositoryProtocol

    init(repository: OrdersRepositoryProtocol) {
        self.repository = repository
    }

    func fetchOrders() -> AnyPublisher<[Order], AppError> {
        return repository.fetchOrders()
    }

    func fetchOrderDetails(with id: Order.ID) -> AnyPublisher<Order, AppError> {
        return repository.fetchOrderDetails(with: id)
    }
}
