//
//  Order.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Foundation

struct Order: ModelIdentifiable, Hashable, Codable {
    enum Status: String, Codable {
        case toPick = "to_pick"
        case picking
        case packed
        case completed
        case cancelled
    }

    struct LineItem: ModelIdentifiable, Hashable, Codable {
        let id: LineItem.ID
        let quantity: Int
        let name: String
        let barcode: String
        let shelfMapping: [String]
        let imageUrl: URL?
    }

    let id: ID
    let orderDisplayId: String
    let customer: String
    let status: Status
    let createdAt: Date
    let numberOfItems: Int
    let storeName: String
    let deliveryNotes: String?
    let lineItems: [LineItem]?
}
