//
//  ApiDTO.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

protocol ApiDTO: ModelConvertable, Codable {}

typealias OrderApiDTO = Order

extension OrderApiDTO: ApiDTO {
    func toDomain() -> Order { self }
}
