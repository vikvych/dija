//
//  OrderLineItemCell.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Combine
import UIKit

class OrderLineItemCell: UITableViewCell {
    let photoView = UIImageView()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    let barcodeLabel = UILabel()
    let detailsLabel = UILabel()
    let containerView = UIView()
    var cancellable: Cancellable?

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

private extension OrderLineItemCell {
    func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)

        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = Paddings.pt6
        containerView.backgroundColor = .App.contentBackground
        containerView.addSubview(photoView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(countLabel)
        containerView.addSubview(barcodeLabel)
        containerView.addSubview(detailsLabel)

        photoView.layer.masksToBounds = true
        photoView.layer.cornerRadius = Paddings.pt6
        photoView.backgroundColor = .App.statusToPick
        titleLabel.font = .App.secondarySubtitle
        countLabel.font = .App.secondarySubtitle
        barcodeLabel.font = .App.caption
        detailsLabel.font = .App.secondaryBody
    }

    func setupConstraints() {
        containerView.layout { view in
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: Paddings.hDefault)
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Paddings.vSmall)
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Paddings.hDefault)
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Paddings.hDefault)
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Paddings.vSmall)
        }

        photoView.layout { view in
            view.widthAnchor.constraint(equalToConstant: 48)
            view.heightAnchor.constraint(equalToConstant: 48)
            view.topAnchor.constraint(equalTo: containerView.topAnchor)
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            containerView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor)
        }

        titleLabel.layout { label in
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.vDefault)
            label.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: Paddings.hDefault)
        }

        countLabel.layout { label in
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.vDefault)
            label.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: Paddings.hSmall)
            containerView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: Paddings.hDefault)
        }

        barcodeLabel.layout { label in
            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Paddings.vSmall)
            label.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: Paddings.hDefault)
        }

        detailsLabel.layout { label in
            label.topAnchor.constraint(equalTo: barcodeLabel.bottomAnchor, constant: Paddings.vSmall)
            label.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: Paddings.hDefault)
            containerView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: Paddings.vDefault)
        }
    }
}
