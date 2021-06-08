//
//  LocalRequestBuilder.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Foundation

/**
 Local request builder for testing purposes
 */
struct LocalRequestBuilder: ApiServiceRequestBuilder {
    func build(for endpoint: ApiContract.Endpoint) -> URLRequest? {
        guard let url = Bundle.main.url(forResource: endpoint.resource, withExtension: "json") else { return nil }
        return URLRequest(url: url)
    }
}

private extension ApiContract.Endpoint {
    var resource: String {
        switch self {
        case .orders:
            return "orders-list"
        case .orderDetails(let id):
            return "order-\(id.rawValue)"
        }
    }
}
