//
//  Identifier+Codable.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

extension Identifier: Codable where Value: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(rawValue: try container.decode(Value.self))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
