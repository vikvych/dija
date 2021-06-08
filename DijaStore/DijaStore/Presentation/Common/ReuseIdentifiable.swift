//
//  ReuseIdentifiable.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
