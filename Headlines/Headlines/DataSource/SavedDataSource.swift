//
//  SavedDataSource.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - UITableviewDatasource
final class SavedDataSource : GenericDataSource<Article>, UITableViewDataSource {
    
    private lazy var realMViewModel: RealMViewModel = {
        let result = RealMViewModel()
        result.delegate = self
        return result
    }()
    
    // Number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }

    // Cell configuration and setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeadlineCell") as! NewsHeadlineCell
        cell.configureCell(headlines: self.data.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realMViewModel.deleteRecords(headline: self.data.value[indexPath.row])
            self.data.value.remove(at: indexPath.row)
        }
    }
}


extension SavedDataSource: RealMViewModelDelegate {
    
}
