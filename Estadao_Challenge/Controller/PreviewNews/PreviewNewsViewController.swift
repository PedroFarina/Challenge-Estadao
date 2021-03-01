//
//  PreviewNewsViewController.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import UIKit

internal class PreviewNewsViewController: UIViewController {

    private let client: APIClient

    init(client: APIClient) {
        self.client = client
        super.init(nibName: nil, bundle: nil)

        client.fetchPreviewNews { (result) in
            DispatchQueue.main.async { [weak self] in
                if let news = try? result.get() {
                    self?.tableViewDataSource = PreviewNewsTableViewDataSource(news: news)
                    self?.tableView.dataSource = self?.tableViewDataSource
                    self?.tableView.reloadData()
                }
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("Não estou usando storyboard")
    }

    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        

        return tableView
    }()
    private var tableViewDataSource: PreviewNewsTableViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Noticias"

        view.addSubview(tableView)
        activateConstraints()
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
