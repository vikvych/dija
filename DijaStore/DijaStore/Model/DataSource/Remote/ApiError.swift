//
//  ApiError.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

enum ApiError: Error {
    case invalidRequest
    case failedToDecode(Error)
    case generic(Error)
}
