//
//  OrdersViewController.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Combine
import UIKit

protocol OrdersViewModelProtocol {
    var ordersPublisher: AnyPublisher<[Order], Never> { get }

    func fetch()
    func selectOrder(at index: Int)
}

class OrdersViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    private lazy var tableView = UITableView()
    private lazy var dataSource = OrdersViewDataSource(tableView: tableView)

    private let viewModel: OrdersViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: OrdersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bindViewModel()
    }
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectOrder(at: indexPath.row)
    }
}

private extension OrdersViewController {
    @objc func refetch() {
        viewModel.fetch()
    }

    func setupViews() {
        title = "Orders"
        view.backgroundColor = .App.background
        view.addSubview(tableView)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.addSubview(refreshControl)
        tableView.delegate = self

        refreshControl.addTarget(self, action: #selector(refetch), for: .valueChanged)
    }

    func setupConstraints() {
        tableView.layout(in: view)
    }

    func bindViewModel() {
        viewModel.fetch()
        viewModel.ordersPublisher
            .sink { [weak self] orders in self?.apply(orders: orders) }
            .store(in: &cancellables)
    }

    func apply(orders: [Order]) {
        var snapshot = OrdersViewDataSource.Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(orders)
        dataSource.apply(snapshot)
        refreshControl.endRefreshing()
    }
}
