//
//  LayoutBuilder.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import UIKit

@resultBuilder struct LayoutBuilder {
    static func buildBlock(_ constrains: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        return constrains
    }
}

extension UIView {
    func layout(@LayoutBuilder using builder: (_ view: UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(builder(self))
    }

    func layout(in superview: UIView) {
        layout { view in
            view.topAnchor.constraint(equalTo: superview.topAnchor)
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor)
            superview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            superview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }
    }
}
