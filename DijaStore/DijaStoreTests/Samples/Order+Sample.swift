//
//  Order+Sample.swift
//  DijaStoreTests
//
//  Created by Ivan Tkachenko on 6/8/21.
//

import Foundation
@testable import DijaStore

extension Order {
    static func sample(
        id: ID = .init(rawValue: 123),
        orderDisplayId: String = "456",
        customer: String = "John Wick",
        status: Status = .toPick,
        createdAt: Date = Date(timeIntervalSince1970: 0),
        numberOfItems: Int = 1,
        storeName: String = "Mega store",
        deliveryNotes: String? = nil,
        lineItems: [LineItem]? = nil
    ) -> Order {
        return .init(
            id: id,
            orderDisplayId: orderDisplayId,
            customer: customer,
            status: status,
            createdAt: createdAt,
            numberOfItems: numberOfItems,
            storeName: storeName,
            deliveryNotes: deliveryNotes,
            lineItems: lineItems
        )
    }
}
