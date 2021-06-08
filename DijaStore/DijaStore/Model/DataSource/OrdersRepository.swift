//
//  OrdersRepository.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Foundation
import Combine

protocol OrdersRemoteDataSource {
    func fetchOrders() -> AnyPublisher<[OrderApiDTO], ApiError>
    func fetchOrderDetails(with id: Order.ID) -> AnyPublisher<OrderApiDTO, ApiError>
}

class OrdersRepository: OrdersRepositoryProtocol {
    private let remoteDataSource: OrdersRemoteDataSource

    init(remoteDataSource: OrdersRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchOrders() -> AnyPublisher<[Order], AppError> {
        return remoteDataSource.fetchOrders()
            .map { dtos in
                dtos.map { dto in
                    dto.toDomain()
                }
            }
            .mapError(AppError.api)
            .eraseToAnyPublisher()
    }

    func fetchOrderDetails(with id: Order.ID) -> AnyPublisher<Order, AppError> {
        return remoteDataSource.fetchOrderDetails(with: id)
            .map { dto in dto.toDomain() }
            .mapError(AppError.api)
            .eraseToAnyPublisher()
    }
}
