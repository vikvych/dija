//
//  OrderCell.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import UIKit

class OrderCell: UITableViewCell {
    /// Public order id & store name
    let titleLabel = UILabel()
    /// Number of items
    let detailsLabel = UILabel()
    /// Created at
    let createdAtLabel = UILabel()
    /// Order status
    let statusLabel = UILabel()
    /// Stores lables
    let containerView = UIView()
    /// Stores status view
    let statusView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OrderCell {
    func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)

        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = Paddings.pt6
        containerView.backgroundColor = .App.contentBackground
        containerView.addSubview(titleLabel)
        containerView.addSubview(detailsLabel)
        containerView.addSubview(createdAtLabel)
        containerView.addSubview(statusView)

        statusView.layer.masksToBounds = true
        statusView.layer.cornerRadius = Paddings.hSmall
        statusView.addSubview(statusLabel)

        titleLabel.font = .App.subtitle
        detailsLabel.font = .App.secondaryBody
        createdAtLabel.font = .App.caption
        statusLabel.font = .App.controlCaption
        statusLabel.textColor = .App.contentBackground
    }

    func setupConstraints() {
        containerView.layout { view in
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: Paddings.hDefault)
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Paddings.vSmall)
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Paddings.hDefault)
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Paddings.hDefault)
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Paddings.vSmall)
        }

        titleLabel.layout { label in
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.vDefault)
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.hDefault)
        }

        detailsLabel.layout { label in
            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Paddings.vSmall)
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.hDefault)
        }

        createdAtLabel.layout { label in
            label.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: Paddings.vSmall)
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.hDefault)
            containerView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: Paddings.vDefault)
        }

        statusView.layout { view in
            view.heightAnchor.constraint(equalToConstant: Paddings.hDefault)
            view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.vDefault)
            view.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: Paddings.hSmall)
            view.leadingAnchor.constraint(greaterThanOrEqualTo: detailsLabel.trailingAnchor, constant: Paddings.hSmall)
            view.leadingAnchor.constraint(greaterThanOrEqualTo: createdAtLabel.trailingAnchor, constant: Paddings.hSmall)
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Paddings.hDefault)
        }

        statusLabel.layout { label in
            label.centerYAnchor.constraint(equalTo: statusView.centerYAnchor)
            label.leadingAnchor.constraint(equalTo: statusView.leadingAnchor, constant: Paddings.hSmall)
            statusView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: Paddings.hSmall)
        }
    }
}
