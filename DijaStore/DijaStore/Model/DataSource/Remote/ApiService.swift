//
//  ApiService.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Foundation
import Combine

protocol ApiServiceRequestBuilder {
    func build(for endpoint: ApiContract.Endpoint) -> URLRequest?
}

class ApiService {
    let urlSession: URLSession
    let requestBuilder: ApiServiceRequestBuilder
    let jsonDecoder: JSONDecoder

    init(
        urlSession: URLSession = .shared,
        requestBuilder: ApiServiceRequestBuilder = LocalRequestBuilder(),
        jsonDecoder: JSONDecoder = .makeDefault()
    ) {
        self.urlSession = urlSession
        self.requestBuilder = requestBuilder
        self.jsonDecoder = jsonDecoder
    }

    func perform<Result: Decodable>(request: URLRequest) -> AnyPublisher<Result, ApiError> {
        return urlSession.dataTaskPublisher(for: request)
            .mapError(ApiError.generic)
            .flatMap { [jsonDecoder] data, response in
                Just(data)
                    .decode(type: Result.self, decoder: jsonDecoder)
                    .mapError(ApiError.failedToDecode)
            }
            .receive(on: DispatchQueue.main)
            .delay(for: 1, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension ApiService {
    func performRequest<Result: Decodable>(with endpoint: ApiContract.Endpoint) -> AnyPublisher<Result, ApiError> {
        guard let request = requestBuilder.build(for: endpoint) else {
            return Fail(error: ApiError.invalidRequest)
                .eraseToAnyPublisher()
        }

        return perform(request: request)
    }
}

private extension JSONDecoder {
    static func makeDefault() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
