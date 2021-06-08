//
//  OrderDeliveryNotesCell.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/8/21.
//

import UIKit

class OrderDeliveryNotesCell: UITableViewCell {
    let titleLabel = UILabel()
    let detailsLabel = UILabel()
    let containerView = UIView()

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

private extension OrderDeliveryNotesCell {
    func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)

        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = Paddings.pt6
        containerView.backgroundColor = .App.contentBackground
        containerView.addSubview(titleLabel)
        containerView.addSubview(detailsLabel)

        titleLabel.font = .App.caption
        detailsLabel.font = .App.secondaryBody
        detailsLabel.numberOfLines = 0
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
            containerView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: Paddings.hDefault)
        }

        detailsLabel.layout { label in
            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Paddings.vSmall)
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.hDefault)
            containerView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: Paddings.hDefault)
            containerView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: Paddings.vDefault)
        }
    }

}
