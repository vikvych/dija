//
//  ModelConvertable.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

protocol ModelConvertable {
    associatedtype DomainType: ModelIdentifiable

    func toDomain() -> DomainType
}
