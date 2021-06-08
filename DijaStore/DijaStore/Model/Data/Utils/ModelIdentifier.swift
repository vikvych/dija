//
//  ModelIdentifier.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

protocol ModelIdentifiable: Identifiable {
    associatedtype ID = Identifier<Int, Self>
}
