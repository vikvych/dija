//
//  ApiService+Orders.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Combine

extension ApiService: OrdersRemoteDataSource {
    func fetchOrders() -> AnyPublisher<[OrderApiDTO], ApiError> {
        return performRequest(with: .orders)
    }

    func fetchOrderDetails(with id: Order.ID) -> AnyPublisher<OrderApiDTO, ApiError> {
        return performRequest(with: .orderDetails(id))
    }
}
