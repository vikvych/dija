//
//  OrdersViewDataSource.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import UIKit

typealias OrdersViewDataSource = UITableViewDiffableDataSource<Int, Order>

extension OrdersViewDataSource {
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>

    convenience init(tableView: UITableView) {
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.reuseIdentifier)

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium

        self.init(tableView: tableView) { tableView, indexPath, order in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OrderCell.reuseIdentifier,
                for: indexPath
            ) as! OrderCell

            cell.titleLabel.text = "\(order.orderDisplayId) · \(order.storeName)"
            cell.detailsLabel.text = "\(order.numberOfItems) items"
            cell.statusLabel.text = order.status.stringValue.uppercased()
            cell.statusView.backgroundColor = order.status.statusColor
            cell.createdAtLabel.text = dateFormatter.string(from: order.createdAt)

            return cell
        }
    }
}

extension Order.Status {
    var stringValue: String {
        switch self {
        case .toPick:
            return "To Pick"
        case .picking:
            return "Picking"
        case .packed:
            return "Packed"
        case .completed:
            return "Completed"
        case .cancelled:
            return "Cancelled"
        }
    }

    var statusColor: UIColor? {
        switch self {
        case .toPick:
            return .App.statusToPick
        case .picking:
            return .App.statusPicking
        case .packed:
            return .App.statusPacked
        case .completed:
            return .App.statusCompleted
        case .cancelled:
            return .App.statusCancelled
        }
    }
}
