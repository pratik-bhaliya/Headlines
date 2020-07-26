//
//  HeadlinesViewController.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit

final class HeadlinesViewController: UIViewController {
    
    enum Constant {
        static let height: CGFloat = 300.0
    }
    
    // MARK: - IBOutlet connection from storyboard
    @IBOutlet weak var headlinesTableView: UITableView!
    
    // MARK: - Instant Properties
    var dataSource = HeadlineListDataSource()
    var selectedArticle = 0
    lazy var viewModel: HeadlineViewModel = {
        let viewModel = HeadlineViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    private lazy var realMViewModel: RealMViewModel = {
        let result = RealMViewModel()
        result.delegate = self
        return result
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAndSetupTableView()
        errorHandlingAlert()
        updateDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SelectedSource.shared.collectionArray.count == 0 {
            self.viewModel.getTopHeadlines()
        } else {
            self.viewModel.getTopHeadlinesBySource()
        }
    }
    
    // MARK: - Class
    fileprivate func registerAndSetupTableView() {
        headlinesTableView.register(UINib(nibName: "NewsHeadlineCell", bundle: nil), forCellReuseIdentifier: "NewsHeadlineCell")
        
        // Assigning datasource and delegate
        self.headlinesTableView.delegate = self
        self.headlinesTableView.dataSource = self.dataSource
        
        // Empty tableview will be clear to zero
        self.headlinesTableView.tableFooterView = UIView()
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
                self.headlinesTableView.reloadData()
            }
        }
    }
}


extension HeadlinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHeadlineURL = self.dataSource.data.value[indexPath.row].url
        let detailViewController = HeadlineDetailViewController()
        selectedArticle = indexPath.row
        detailViewController.delegate = self
        detailViewController.urlString = selectedHeadlineURL
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}


extension HeadlinesViewController: RealMViewModelDelegate {
    
    func objectSaved() {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: "Headline", message: "Article successfully saved.", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func objectSavingFailed(error: NSError) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: "Headline", message: "Oops, Article couldn't saved!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
}


extension HeadlinesViewController: SaveArticleDelegate {
    func saveArticle() {
        let article = self.dataSource.data.value[selectedArticle]
        let savedArticle = SavedArticle(article: article)
        realMViewModel.insertObject(savedArticle)
    }
}
