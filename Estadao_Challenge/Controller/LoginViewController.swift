//
//  LoginViewController.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 27/02/21.
//

import UIKit

class LoginViewController: UIViewController {

    private let client = APIClient(credentials: .defaultEstadao)

    private let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let statusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center

        return label
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginTap), for: .touchUpInside)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "person"), for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(activityView)
        view.addSubview(loginButton)
        view.addSubview(statusLabel)

        activateConstraints()
    }

    func activateConstraints() {
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NSLayoutConstraint(item: loginButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.5, constant: 0),

            statusLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        ])
    }

    @objc func loginTap() {
        loginButton.setImage(UIImage(systemName: "person.fill"), for: .normal)
        activityView.startAnimating()
        client.login { [weak self] (result) in
            DispatchQueue.main.async {
                self?.activityView.stopAnimating()
                self?.loginButton.setImage(UIImage(systemName: "person"), for: .normal)
            }

            let mainQueueAction: () -> Void
            do {
                if try result.get() {
                    mainQueueAction = {
                        let previewNewsViewController = PreviewNewsViewController()
                        previewNewsViewController.modalPresentationStyle = .fullScreen
                        self?.present(previewNewsViewController, animated: true)
                    }
                } else {
                    mainQueueAction = { self?.statusLabel.text = "Ops! Não foi possível logar. Favor tentar novamente." }
                }
            } catch {
                let message: String
                if let error = error as? APIClient.APIErrors {
                    switch error {
                    case .unexpectedAnswer:
                        message = "A resposta do servidor não foi a esperada."
                    }
                } else {
                    message = error.localizedDescription
                }
                mainQueueAction = { self?.statusLabel.text = "Ops! Occoreu um erro: \(message)" }
            }
            DispatchQueue.main.async {
                mainQueueAction()
            }
        }
    }
}

