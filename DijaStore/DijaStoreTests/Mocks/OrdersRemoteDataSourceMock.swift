//
//  OrdersRemoteDataSourceMock.swift
//  DijaStoreTests
//
//  Created by Ivan Tkachenko on 6/8/21.
//

import Combine
@testable import DijaStore

class OrdersRemoteDataSourceMock: OrdersRemoteDataSource {
    var fetchOrdersCalled = false
    var fetchOrdersMock = PassthroughSubject<[OrderApiDTO], ApiError>()
    func fetchOrders() -> AnyPublisher<[OrderApiDTO], ApiError> {
        fetchOrdersCalled = true
        return fetchOrdersMock.eraseToAnyPublisher()
    }

    var fetchOrderDetailsInput: Order.ID?
    var fetchOrderDetailsMock = PassthroughSubject<OrderApiDTO, ApiError>()
    func fetchOrderDetails(with id: Order.ID) -> AnyPublisher<OrderApiDTO, ApiError> {
        fetchOrderDetailsInput = id
        return fetchOrderDetailsMock.eraseToAnyPublisher()
    }
}
