//
//  Identifier.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

struct Identifier<Value: Hashable, Target: Identifiable>: RawRepresentable, Hashable {
    let rawValue: Value
}
