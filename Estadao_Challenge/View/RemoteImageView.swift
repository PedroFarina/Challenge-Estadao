//
//  RemoteImageView.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import UIKit

internal class RemoteImageView: UIImageView {

    override var image: UIImage? {
        get {
            return super.image
        }
        set {
            DispatchQueue.main.async {
                super.image = newValue
                if newValue == nil {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    internal var url: URL? {
        didSet {
            image = nil
            if let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                self.image = image
            }
        }
    }

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupSubviews() {
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
