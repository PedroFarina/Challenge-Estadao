//
//  PreviewNewsViewController.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import UIKit

internal class PreviewNewsViewController: UIViewController, PreviewNewsTableViewDelegateObserver {

    private let client: APIClient

    init(client: APIClient) {
        self.client = client
        super.init(nibName: nil, bundle: nil)

        client.fetchPreviewNews { (result) in
            DispatchQueue.main.async { [weak self] in
                do {
                    let news = try result.get()
                    self?.tableViewDataSource = PreviewNewsTableViewDataSource(news: news)
                    self?.tableView.dataSource = self?.tableViewDataSource
                    self?.tableView.reloadData()
                } catch {
                    self?.presentError(error)
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
    private let tableViewDelegate = PreviewNewsTableViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Noticias"
        tableView.delegate = tableViewDelegate
        tableViewDelegate.observer = self

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

    private func presentError(_ err: Error) {
        let alertController = UIAlertController(title: "Error!", message: err.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }

    internal func didSelectNewsWithID(_ id: String) {
        client.fetchFullNews(id: id) { [weak self] (result) in
            DispatchQueue.main.async {
                do {
                    if let fullNews = (try result.get()).first {
                        let viewController = FullNewsViewController(news: fullNews)
                        self?.navigationController?.pushViewController(viewController, animated: true)
                    }
                } catch {
                    self?.presentError(error)
                }
            }
        }
    }
}
