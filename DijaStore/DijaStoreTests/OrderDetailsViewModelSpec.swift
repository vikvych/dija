//
//  OrderDetailsViewModelSpec.swift
//  DijaStoreTests
//
//  Created by Ivan Tkachenko on 6/8/21.
//

import Quick
import Nimble
import Combine
@testable import DijaStore

class OrderDetailsViewModelSpec: QuickSpec {
    override func spec() {
        var viewModel: OrderDetailsViewModel!
        var mockOrdersInteractor: OrdersInteractorMock!
        var cancellables: Set<AnyCancellable>!

        beforeEach {
            cancellables = []
            mockOrdersInteractor = OrdersInteractorMock()
        }

        describe("Data fetching") {
            context("when orders publisher is subscribed") {
                var details: [OrderDetailsItem]?
                var title: String?
                var error: Error?

                beforeEach {
                    details = nil
                    title = nil
                    error = nil
                    
                    viewModel = makeViewModel(
                        handleError: { err, _ in error = err }
                    )

                    viewModel.fetch()
                    viewModel.titlePublisher
                        .sink { title = $0 }
                        .store(in: &cancellables)

                    viewModel.detailsPublisher
                        .sink { details = $0 }
                        .store(in: &cancellables)
                }

                it("should fetch orders") {
                    expect(mockOrdersInteractor.fetchOrderDetailsInput) == Order.sample().id
                }

                context("when fetch is successful") {
                    beforeEach {
                        mockOrdersInteractor.fetchOrderDetailsMock.send(.sample())
                    }

                    it("should publish order details") {
                        expect(details?.count) == 1
                        expect(error).to(beNil())
                    }

                    it("should publish title") {
                        let order = Order.sample()
                        expect(title) == "\(order.orderDisplayId) · \(order.storeName)"
                    }
                }

                context("when fetch is failed") {
                    beforeEach {
                        mockOrdersInteractor.fetchOrderDetailsMock.send(completion: .failure(.generic(SampleError.sample)))
                    }

                    it("should call error handler") {
                        guard let appError = error as? AppError,
                              case .generic = appError else { return fail() }
                    }
                }
            }
        }
        func makeViewModel(
            order: Order = .sample(),
            handleError: @escaping (AppError, @escaping () -> Void) -> Void = { _, _ in }
        ) -> OrderDetailsViewModel {
            return OrderDetailsViewModel(
                order: order,
                dependencies: DependencyContainer(
                    orders: mockOrdersInteractor
                ),
                callbacks: .init(
                    handleError: handleError
                )
            )
        }
    }
}
