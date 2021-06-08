//
//  Dependencies.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Combine

protocol OrdersInteractorProtocol {
    func fetchOrders() -> AnyPublisher<[Order], AppError>
    func fetchOrderDetails(with id: Order.ID) -> AnyPublisher<Order, AppError>
}

protocol OrdersInteractorProvider {
    var orders: OrdersInteractorProtocol { get }
}
