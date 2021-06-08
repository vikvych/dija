//
//  DependencyContainer.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

struct DependencyContainer: OrdersInteractorProvider {
    let orders: OrdersInteractorProtocol
}

extension DependencyContainer {
    static func makeDefault() -> DependencyContainer {
        let apiService = ApiService()

        return DependencyContainer(
            orders: OrdersInteractor(
                repository: OrdersRepository(remoteDataSource: apiService)
            )
        )
    }
}
