//
//  OrdersRepositorySpec.swift
//  DijaStoreTests
//
//  Created by Ivan Tkachenko on 6/8/21.
//

import Quick
import Nimble
import Combine
@testable import DijaStore

class OrdersRepositorySpec: QuickSpec {
    override func spec() {
        var repository: OrdersRepository!
        var mockRemoteDataSource: OrdersRemoteDataSourceMock!
        var cancellables: Set<AnyCancellable>!

        beforeEach {
            cancellables = []
            mockRemoteDataSource = OrdersRemoteDataSourceMock()
            repository = OrdersRepository(remoteDataSource: mockRemoteDataSource)
        }

        describe("Data fetching") {
            context("when fetched orders") {
                var value: [Order]?
                var error: Error?

                beforeEach {
                    value = nil
                    error = nil
                    repository.fetchOrders()
                        .sink(
                            receiveCompletion: { result in
                                guard case .failure(let err) = result else { return }
                                error = err
                            },
                            receiveValue: { v in
                                value = v
                            }
                        )
                        .store(in: &cancellables)
                }

                it("should call repository") {
                    expect(mockRemoteDataSource.fetchOrdersCalled) == true
                }

                context("when fetch suceeds") {
                    beforeEach {
                        mockRemoteDataSource.fetchOrdersMock.send([.sample()])
                    }

                    it("should return orders") {
                        expect(value) == [.sample()]
                        expect(error).to(beNil())
                    }
                }

                context("when fetch fails") {
                    beforeEach {
                        mockRemoteDataSource.fetchOrdersMock.send(completion: .failure(.generic(SampleError.sample)))
                    }

                    it("should return error") {
                        guard let appError = error as? AppError,
                              case .api = appError else { return fail() }
                        expect(value).to(beNil())
                    }
                }
            }

            context("when fetch order details") {
                var value: Order?
                var error: Error?

                beforeEach {
                    value = nil
                    error = nil
                    repository.fetchOrderDetails(with: .init(rawValue: 123))
                        .sink(
                            receiveCompletion: { result in
                                guard case .failure(let err) = result else { return }
                                error = err
                            },
                            receiveValue: { v in
                                value = v
                            }
                        )
                        .store(in: &cancellables)
                }

                it("should call repository") {
                    expect(mockRemoteDataSource.fetchOrderDetailsInput) == .init(rawValue: 123)
                }

                context("when fetch suceeds") {
                    beforeEach {
                        mockRemoteDataSource.fetchOrderDetailsMock.send(.sample())
                    }

                    it("should return orders") {
                        expect(value) == .sample()
                        expect(error).to(beNil())
                    }
                }

                context("when fetch fails") {
                    beforeEach {
                        mockRemoteDataSource.fetchOrderDetailsMock.send(completion: .failure(.generic(SampleError.sample)))
                    }

                    it("should return error") {
                        guard let appError = error as? AppError,
                              case .api = appError else { return fail() }
                        expect(value).to(beNil())
                    }
                }
            }
        }
    }
}
