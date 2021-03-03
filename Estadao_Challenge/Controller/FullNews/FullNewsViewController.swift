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

    internal init(news fullNews: FullNews) {
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
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let titleLabel: UILabel = .makeViewCodeLabel(with: .title2)
    private let bodyLabel: UILabel  = .makeViewCodeLabel(with: .body)
    private let dateLabel: UILabel = .makeViewCodeLabel(with: .callout)
    private let sourceLabel: UILabel = .makeViewCodeLabel(with: .callout)

    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(sourceLabel)
        activateConstraints()
        DispatchQueue.main.async {
            self.bodyLabel.attributedText = self.bodyLabel.attributedText?.fitImagesToScreenSize(maxWidth: self.bodyLabel.frame.width)
        }
    }

    private func activateConstraints() {
        var constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
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
