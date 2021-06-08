//
//  Assets.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import UIKit

extension UIColor {
    enum App {
        static let foreground = UIColor(named: "foreground")
        static let background = UIColor(named: "background")
        static let contentBackground = UIColor(named: "contentBackground")
        static let accent = UIColor(named: "accent")

        static let statusToPick = UIColor(named: "statusToPick")
        static let statusPicking = UIColor(named: "statusPicking")
        static let statusPacked = UIColor(named: "statusPacked")
        static let statusCompleted = UIColor(named: "statusCompleted")
        static let statusCancelled = UIColor(named: "statusCancelled")
    }
}
