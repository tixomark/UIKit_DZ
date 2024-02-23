// WebViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Экран для работы с веб страницами
final class WebViewController: UIViewController {
    // MARK: - Visual Components

    private let webView = WKWebView()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.closeButon, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: .previousIcon,
            style: .plain,
            target: self,
            action: #selector(toolBarButtonTapped(_:))
        )
        return button
    }()

    private lazy var forwardButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: .nextIcon,
            style: .plain,
            target: self,
            action: #selector(toolBarButtonTapped(_:))
        )
        return button
    }()

    private lazy var reloadButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: .reloadIcon,
            style: .plain,
            target: self,
            action: #selector(toolBarButtonTapped(_:))
        )
        return button
    }()

    private lazy var toolBar: UIToolbar = {
        let bar = UIToolbar()
        bar.items = [
            .fixedSpace(23),
            backButton,
            .fixedSpace(43),
            forwardButton,
            .flexibleSpace(),
            reloadButton,
            .fixedSpace(20)
        ]
        bar.tintColor = .accent
        bar.isTranslucent = true
        return bar
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func configure(with link: String) {
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubviews(webView, toolBar, closeButton)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: closeButton, webView, toolBar)
        configureCloseButtonLayout()
        configureWebViewLayout()
        configureToolBarLayout()
    }

    private func configureCloseButtonLayout() {
        [
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor)
        ].activate()
    }

    private func configureWebViewLayout() {
        [
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ].activate()
    }

    private func configureToolBarLayout() {
        [
            toolBar.topAnchor.constraint(equalTo: webView.bottomAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }

    @objc private func toolBarButtonTapped(_ sender: UIBarButtonItem) {
        switch sender {
        case backButton:
            guard webView.canGoBack else { return }
            webView.goBack()
        case forwardButton:
            guard webView.canGoForward else { return }
            webView.goForward()
        case reloadButton:
            webView.reload()
        default:
            break
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
