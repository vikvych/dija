//
//  ApiContract.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

enum ApiContract {
    enum Endpoint {
        case orders
        case orderDetails(Order.ID)
    }
}
