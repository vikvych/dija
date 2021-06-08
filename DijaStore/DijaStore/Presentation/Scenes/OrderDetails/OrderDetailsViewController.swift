//
//  OrderDetailsViewController.swift
//  DijaStore
//
//  Created by Ivan Tkachenko on 6/7/21.
//

import Combine
import UIKit

protocol OrderDetailsViewModelProtocol {
    var titlePublisher: AnyPublisher<String, Never> { get }
    var detailsPublisher: AnyPublisher<[OrderDetailsItem], Never> { get }

    func fetch()
}

class OrderDetailsViewController: UIViewController {
    private lazy var tableView = UITableView()
    private lazy var dataSource = OrderDetailsViewDataSource(tableView: tableView)

    private let viewModel: OrderDetailsViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: OrderDetailsViewModelProtocol) {
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

private extension OrderDetailsViewController {
    func setupViews() {
        view.backgroundColor = .App.background
        view.addSubview(tableView)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }

    func setupConstraints() {
        tableView.layout(in: view)
    }

    func bindViewModel() {
        viewModel.fetch()
        viewModel.titlePublisher
            .sink { [weak self] title in self?.title = title }
            .store(in: &cancellables)

        viewModel.detailsPublisher
            .sink { [weak self] details in self?.apply(details: details) }
            .store(in: &cancellables)
    }

    func apply(details: [OrderDetailsItem]) {
        var snapshot = OrderDetailsViewDataSource.Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(details)
        dataSource.apply(snapshot)
    }
}
