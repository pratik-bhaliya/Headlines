//
//  SourcesViewController.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit

final class SourcesViewController: UIViewController {
    
    // MARK: - IBOutlet connection from storyboard
    @IBOutlet weak var sourceTableView: UITableView!
    
    // MARK: - Instant Properties
    var dataSource = SourceListDataSource()
    lazy var viewModel: SourceViewModel = {
        let viewModel = SourceViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAndSetupTableView()
        self.viewModel.getSources()
        errorHandlingAlert()
        updateDataSource()
    }
    
    // MARK: - Class
    fileprivate func registerAndSetupTableView() {
        sourceTableView.register(UINib(nibName: "SourcesTableViewCell", bundle: nil), forCellReuseIdentifier: "SourcesTableViewCell")
        
        // Assigning datasource and delegate
        self.sourceTableView.delegate = self.dataSource
        self.sourceTableView.dataSource = self.dataSource
        
        sourceTableView.estimatedRowHeight = 100.0
        sourceTableView.rowHeight = UITableView.automaticDimension
        
        // Empty tableview will be clear to zero
        self.sourceTableView.tableFooterView = UIView()
    }
    
    fileprivate func errorHandlingAlert() {
        self.viewModel.onErrorHandling = { [weak self] error in
            DispatchQueue.main.async {
                let controller = UIAlertController(title: "An error occurred", message: "Oops, something went wrong!", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                self?.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    // This method will notify tableview datasource
    fileprivate func updateDataSource() {
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.sourceTableView.reloadData()
            }
        }
    }
    
}
