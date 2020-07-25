//
//  ViewController.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit
import SafariServices

final class SavedViewController: UIViewController {
    enum Constant {
        static let height: CGFloat = 300.0
    }
    
    // MARK: - IBOutlet connection from storyboard
    @IBOutlet weak var savedTableView: UITableView!
    
    // MARK: - Instant Properties
    var dataSource = SavedDataSource()
    lazy var viewModel: SavedViewModel = {
        let viewModel = SavedViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAndSetupTableView()
        updateDataSource()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchRecord()
    }
    
    // MARK: - Class
    fileprivate func registerAndSetupTableView() {
        savedTableView.register(UINib(nibName: "NewsHeadlineCell", bundle: nil), forCellReuseIdentifier: "NewsHeadlineCell")
        
        // Assigning datasource and delegate
        self.savedTableView.delegate = self
        self.savedTableView.dataSource = self.dataSource
        
        // Empty tableview will be clear to zero
        self.savedTableView.tableFooterView = UIView()
    }
    
    // This method will notify tableview datasource
    fileprivate func updateDataSource() {
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.savedTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedNews = self.dataSource.data.value[indexPath.row].url
            let headlineDetail = SFSafariViewController(url: URL(string: selectedNews)!)
            present(headlineDetail, animated: true)
    }
}

