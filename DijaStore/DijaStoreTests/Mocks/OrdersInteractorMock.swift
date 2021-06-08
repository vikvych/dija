//
//  OrdersInteractorMock.swift
//  DijaStoreTests
//
//  Created by Ivan Tkachenko on 6/8/21.
//

import Combine
@testable import DijaStore

class OrdersInteractorMock: OrdersInteractorProtocol {
    var fetchOrdersCalled = false
    var fetchOrdersMock = PassthroughSubject<[Order], AppError>()
    func fetchOrders() -> AnyPublisher<[Order], AppError> {
        fetchOrdersCalled = true
        return fetchOrdersMock.eraseToAnyPublisher()
    }

    var fetchOrderDetailsInput: Order.ID?
    var fetchOrderDetailsMock = PassthroughSubject<Order, AppError>()
    func fetchOrderDetails(with id: Order.ID) -> AnyPublisher<Order, AppError> {
        fetchOrderDetailsInput = id
        return fetchOrderDetailsMock.eraseToAnyPublisher()
    }
}
