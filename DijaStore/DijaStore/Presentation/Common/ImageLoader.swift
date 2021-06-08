//
//  ImageLoader.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/8/21.
//

import Combine
import UIKit

struct ImageLoader {
    let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func loadImage(with url: URL) -> AnyPublisher<UIImage?, ApiError> {
        urlSession.dataTaskPublisher(for: url)
            .map { data, _ in UIImage(data: data) }
            .mapError(ApiError.generic)
            .eraseToAnyPublisher()
    }
}
