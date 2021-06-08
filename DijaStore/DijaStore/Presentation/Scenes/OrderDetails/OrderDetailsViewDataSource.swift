//
//  OrderDetailsViewDataSource.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import UIKit

struct OrderDetailsItem: Hashable {
    enum Info: Hashable {
        case orderDetails(Order)
        case deliveryNotes(String)
        case lineItem(Order.LineItem)
    }

    let uuid = UUID()
    let info: Info
}

typealias OrderDetailsViewDataSource = UITableViewDiffableDataSource<Int, OrderDetailsItem>

extension OrderDetailsViewDataSource {
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>

    convenience init(tableView: UITableView) {
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.reuseIdentifier)
        tableView.register(OrderDeliveryNotesCell.self, forCellReuseIdentifier: OrderDeliveryNotesCell.reuseIdentifier)
        tableView.register(OrderLineItemCell.self, forCellReuseIdentifier: OrderLineItemCell.reuseIdentifier)

        self.init(tableView: tableView) { tableView, indexPath, item in
            item.setupCell(with: tableView, indexPath: indexPath)
        }

        defaultRowAnimation = .fade
    }
}

private extension OrderDetailsItem {
    func setupCell(with tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch info {
        case .orderDetails(let order):
            return configureCell(
                dequeueCell(with: tableView, indexPath: indexPath),
                with: order
            )
        case .deliveryNotes(let notes):
            return configureCell(
                dequeueCell(with: tableView, indexPath: indexPath),
                with: notes
            )
        case .lineItem(let lineItem):
            return configureCell(
                dequeueCell(with: tableView, indexPath: indexPath),
                with: lineItem
            )
        }
    }

    func dequeueCell<Cell: UITableViewCell>(with tableView: UITableView, indexPath: IndexPath) -> Cell {
        return tableView.dequeueReusableCell(
            withIdentifier: Cell.reuseIdentifier,
            for: indexPath
        ) as! Cell
    }

    func configureCell(_ cell: OrderCell, with order: Order) -> OrderCell {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium

        cell.titleLabel.text = "\(order.orderDisplayId) · \(order.storeName)"
        cell.detailsLabel.text = "\(order.numberOfItems) items"
        cell.statusLabel.text = order.status.stringValue.uppercased()
        cell.statusView.backgroundColor = order.status.statusColor
        cell.createdAtLabel.text = dateFormatter.string(from: order.createdAt)

        return cell
    }

    func configureCell(_ cell: OrderDeliveryNotesCell, with deliveryNote: String) -> OrderDeliveryNotesCell {
        cell.titleLabel.text = "Delivery notes:"
        cell.detailsLabel.text = deliveryNote
        return cell
    }

    func configureCell(_ cell: OrderLineItemCell, with lineItem: Order.LineItem) -> OrderLineItemCell {
        cell.titleLabel.text = lineItem.name
        cell.countLabel.text = "x\(lineItem.quantity)"
        cell.barcodeLabel.text = lineItem.barcode
        cell.detailsLabel.text = lineItem.shelfMapping.joined(separator: ", ")
        cell.photoView.image = nil
        cell.cancellable = lineItem.imageUrl
            .map { url in
                ImageLoader().loadImage(with: url)
                    .receive(on: DispatchQueue.main)
                    .sink(
                        receiveCompletion: { _ in },
                        receiveValue: { image in cell.photoView.image = image }
                    )
            } ?? nil
        
        return cell
    }
}

