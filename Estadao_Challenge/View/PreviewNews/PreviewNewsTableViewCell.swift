//
//  PreviewNewsTableViewCell.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import UIKit

internal class PreviewNewsTableViewCell: UITableViewCell {
    internal static let reusableIdentifier = "PreviewsNewsCell"

    private let remoteImageView: RemoteImageView = {
        let imageView = RemoteImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true

        return imageView
    }()
    private let titleLabel: UILabel = .makeViewCodeLabel(with: .headline)
    private let previewLabel: UILabel = .makeViewCodeLabel(with: .body)
    private let dateLabel: UILabel = .makeViewCodeLabel(with: .callout)
    private let sourceLabel: UILabel = .makeViewCodeLabel(with: .callout)
    internal let news: PreviewNews

    init(news: PreviewNews) {
        self.news = news
        self.titleLabel.text = news.titulo
        self.previewLabel.text = news.linha_fina
        self.dateLabel.text = news.data_hora_publicacao
        self.sourceLabel.text = news.source
        self.remoteImageView.url = news.imagem
        super.init(style: .default, reuseIdentifier: nil)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("Não estou usando storyboard")
    }

    private func setupSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        contentView.addSubview(remoteImageView)
        contentView.addSubview(previewLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(sourceLabel)
        setupConstraints()
    }

    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),

            remoteImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            remoteImageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            remoteImageView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            remoteImageView.heightAnchor.constraint(equalTo: remoteImageView.widthAnchor, multiplier: 0.55),

            previewLabel.topAnchor.constraint(equalTo: remoteImageView.bottomAnchor, constant: 10),
            previewLabel.leftAnchor.constraint(equalTo: remoteImageView.leftAnchor),
            previewLabel.rightAnchor.constraint(equalTo: remoteImageView.rightAnchor),

            sourceLabel.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 30),
            sourceLabel.leftAnchor.constraint(equalTo: previewLabel.leftAnchor),
            sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

            dateLabel.bottomAnchor.constraint(equalTo: sourceLabel.bottomAnchor),
            dateLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -15)
        ])
    }
}
