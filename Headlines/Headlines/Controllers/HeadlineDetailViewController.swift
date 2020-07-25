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

class HeadlineDetailViewController: UIViewController {
    
    var delegate: SaveArticleDelegate?
    var urlString: String!
    
    lazy var detailWebView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavItem()
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        detailWebView.load(request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    func setupNavItem() {
        let forwardBarItem = UIBarButtonItem(title: "Save", style: .plain, target: self,
                                             action: #selector(saveArticle(sender:)))
        self.navigationItem.rightBarButtonItem = forwardBarItem
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    
    func setupUI() {
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
    
    
    @objc func saveArticle(sender: UIBarButtonItem) {
        delegate?.saveArticle()
    }
}
