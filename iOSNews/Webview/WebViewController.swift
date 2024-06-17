//
//  WebViewController.swift
//  iOSNews
//
//  Created by 서종철 on 6/17/24.
//

import Foundation
import WebKit

class WebViewController: UIViewController {
    var newsURL: String?
    var newsTitle: String?

    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavigationBar()
        setupWebView()
        loadNews()
    }

    private func setupNavigationBar() {
        navigationItem.title = newsTitle
        navigationItem.largeTitleDisplayMode = .never

        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }

    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func loadNews() {
        guard let urlString = newsURL, let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
