//
//  OrdersViewModelSpec.swift
//  DijaStoreTests
//
//  Created by Ivan Tkachenko on 6/8/21.
//

import Quick
import Nimble
import Combine
@testable import DijaStore

class OrdersViewModelSpec: QuickSpec {
    override func spec() {
        var viewModel: OrdersViewModel!
        var mockOrdersInteractor: OrdersInteractorMock!
        var cancellables: Set<AnyCancellable>!

        beforeEach {
            cancellables = []
            mockOrdersInteractor = OrdersInteractorMock()
        }

        describe("Data fetching") {
            context("when orders publisher is subscribed") {
                var value: [Order]?
                var error: Error?

                beforeEach {
                    value = nil
                    error = nil

                    viewModel = makeViewModel(
                        handleError: { err, _ in error = err }
                    )

                    viewModel.fetch()
                    viewModel.ordersPublisher
                        .sink { value = $0 }
                        .store(in: &cancellables)
                }

                it("should fetch orders") {
                    expect(mockOrdersInteractor.fetchOrdersCalled) == true
                }

                context("when fetch is successful") {
                    beforeEach {
                        mockOrdersInteractor.fetchOrdersMock.send([.sample()])
                    }

                    it("should publish orders") {
                        expect(value) == [.sample()]
                        expect(error).to(beNil())
                    }
                }

                context("when fetch is failed") {
                    beforeEach {
                        mockOrdersInteractor.fetchOrdersMock.send(completion: .failure(.generic(SampleError.sample)))
                    }

                    it("should return empty list") {
                        expect(value) == []
                    }

                    it("should call error handler") {
                        guard let appError = error as? AppError,
                              case .generic = appError else { return fail() }
                    }
                }
            }
        }

        describe("Actions") {
            context("when refetch called") {
                beforeEach {
                    viewModel = makeViewModel()
                    viewModel.fetch()
                }

                it("should call fetch orders") {
                    expect(mockOrdersInteractor.fetchOrdersCalled) == true
                }
            }

            context("when order selected") {
                var selectedOrder: Order?

                beforeEach {
                    selectedOrder = nil
                    viewModel = makeViewModel(
                        showDetails: { selectedOrder = $0 }
                    )
                }

                context("when index out of bounds") {
                    beforeEach {
                        viewModel.selectOrder(at: 10)
                    }

                    it("should ignore") {
                        expect(selectedOrder).to(beNil())
                    }
                }

                context("when index is in bounds") {
                    beforeEach {
                        viewModel.fetch()
                        mockOrdersInteractor.fetchOrdersMock.send([.sample()])
                        viewModel.selectOrder(at: 0)
                    }

                    it("should call a callback") {
                        expect(selectedOrder) == .sample()
                    }
                }
            }
        }

        func makeViewModel(
            showDetails: @escaping (Order) -> Void = { _ in },
            handleError: @escaping (AppError, @escaping () -> Void) -> Void = { _, _ in }
        ) -> OrdersViewModel {
            return OrdersViewModel(
                dependencies: DependencyContainer(
                    orders: mockOrdersInteractor
                ),
                callbacks: .init(
                    showDetails: showDetails,
                    handleError: handleError
                )
            )
        }
    }
}
