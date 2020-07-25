//
//  HeadlineDetailViewController.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit
import WebKit

protocol SaveArticleDelegate {
    func saveArticle()
}

final class HeadlineDetailViewController: UIViewController {
    
    // MARK: - Instant Properties
    var delegate: SaveArticleDelegate?
    var urlString: String!
    
    lazy var detailWebView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setWebViewConstraint()
        setupNavItem()
        loadWebView()
    }
    
    // MARK: - Class
    fileprivate func loadWebView() {
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        detailWebView.load(request)
    }
    
    // Customise navigation bar
    fileprivate func setupNavItem() {
        let forwardBarItem = UIBarButtonItem(title: "Save", style: .plain, target: self,
                                             action: #selector(saveButtonPressed(sender:)))
        self.navigationItem.rightBarButtonItem = forwardBarItem
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .black
    }

    // Setting web view and constraint
    fileprivate func setWebViewConstraint() {
        self.view.backgroundColor = .white
        self.view.addSubview(detailWebView)
        
        NSLayoutConstraint.activate([
            detailWebView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            detailWebView.leftAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            detailWebView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            detailWebView.rightAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    // Save button pressed
    @objc func saveButtonPressed(sender: UIBarButtonItem) {
        delegate?.saveArticle()
    }
}
