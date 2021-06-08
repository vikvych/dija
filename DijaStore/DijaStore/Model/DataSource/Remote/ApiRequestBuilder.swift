//
//  ApiRequestBuilder.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Foundation

struct ApiRequestBuilder: ApiServiceRequestBuilder {
    enum HTTPMethod: String {
        case get
        case push
    }

    let baseURL: URL

    func build(for endpoint: ApiContract.Endpoint) -> URLRequest? {
        let url = baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue.uppercased()
        return request
    }
}

private extension ApiContract.Endpoint {
    var path: String {
        switch self {
        case .orders:
            return "orders"
        case .orderDetails(let id):
            return "orders/\(id.rawValue)"
        }
    }

    var httpMethod: ApiRequestBuilder.HTTPMethod {
        return .get
    }
}
