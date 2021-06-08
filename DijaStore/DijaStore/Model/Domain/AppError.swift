//
//  AppError.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

enum AppError: Error {
    case api(ApiError)
    case generic(Error)
}
