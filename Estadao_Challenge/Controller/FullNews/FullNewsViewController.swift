//
//  FullNewsViewController.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 02/03/21.
//

import UIKit

internal class FullNewsViewController: UIViewController {
    private let fullNews: FullNews
    private var document: Document {
        return fullNews.documento
    }

    init(news fullNews: FullNews) {
        self.fullNews = fullNews
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = document.titulo
        bodyLabel.attributedText = document.getCorpoFormatado()
        dateLabel.text = document.datapub
        sourceLabel.text = document.source
    }

    required init?(coder: NSCoder) {
        fatalError("Não estou usando storyboard")
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private let titleLabel: UILabel = .makeViewCodeLabel(with: .title2)
    private let bodyLabel: UILabel  = .makeViewCodeLabel(with: .body)
    private let dateLabel: UILabel = .makeViewCodeLabel(with: .callout)
    private let sourceLabel: UILabel = .makeViewCodeLabel(with: .callout)

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(bodyLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(sourceLabel)
        activateConstraints()
    }

    private func activateConstraints() {
        var constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            sourceLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15)
        ]
        constraints.append(contentsOf: centralizedConstraints(of: bodyLabel, relativeTo: titleLabel, constant: 10))
        constraints.append(contentsOf: centralizedConstraints(of: dateLabel, relativeTo: bodyLabel, constant: 10))
        constraints.append(contentsOf: centralizedConstraints(of: sourceLabel, relativeTo: dateLabel))

        NSLayoutConstraint.activate(constraints)
    }

    private func centralizedConstraints(of view: UIView, relativeTo topView: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            view.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: constant),
            view.leftAnchor.constraint(equalTo: topView.leftAnchor),
            view.rightAnchor.constraint(equalTo: topView.rightAnchor)
        ]
    }
}
