//
//  OrdersInteractorSpec.swift
//  DijaStoreTests
//
//  Created by Ivan Tkachenko on 6/8/21.
//

import Quick
import Nimble
import Combine
@testable import DijaStore

class OrderInteractorSpec: QuickSpec {
    override func spec() {
        var interactor: OrdersInteractor!
        var mockRepository: OrdersRepositoryMock!
        var cancellables: Set<AnyCancellable>!

        beforeEach {
            cancellables = []
            mockRepository = OrdersRepositoryMock()
            interactor = OrdersInteractor(repository: mockRepository)
        }

        describe("Data fetching") {
            context("when fetched orders") {
                var value: [Order]?
                var error: Error?

                beforeEach {
                    value = nil
                    error = nil
                    interactor.fetchOrders()
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
                    expect(mockRepository.fetchOrdersCalled) == true
                }

                context("when fetch suceeds") {
                    beforeEach {
                        mockRepository.fetchOrdersMock.send([.sample()])
                    }

                    it("should return orders") {
                        expect(value) == [.sample()]
                        expect(error).to(beNil())
                    }
                }

                context("when fetch fails") {
                    beforeEach {
                        mockRepository.fetchOrdersMock.send(completion: .failure(.generic(SampleError.sample)))
                    }

                    it("should return error") {
                        guard let appError = error as? AppError,
                              case .generic = appError else { return fail() }
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
                    interactor.fetchOrderDetails(with: .init(rawValue: 123))
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
                    expect(mockRepository.fetchOrderDetailsInput) == .init(rawValue: 123)
                }

                context("when fetch succeeds") {
                    beforeEach {
                        mockRepository.fetchOrderDetailsMock.send(.sample())
                    }

                    it("should return orders") {
                        expect(value) == .sample()
                        expect(error).to(beNil())
                    }
                }

                context("when fetch fails") {
                    beforeEach {
                        mockRepository.fetchOrderDetailsMock.send(completion: .failure(.generic(SampleError.sample)))
                    }

                    it("should return error") {
                        guard let appError = error as? AppError,
                              case .generic = appError else { return fail() }
                        expect(value).to(beNil())
                    }
                }
            }
        }
    }
}
