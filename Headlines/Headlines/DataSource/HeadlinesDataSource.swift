//
//  HeadlinesDataSource.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit

// MARK: - UITableviewDatasource
final class HeadlineListDataSource : GenericDataSource<Article>, UITableViewDataSource {
    // Number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }

    // Cell configuration and setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeadlinesCell") as! NewsHeadlinesCell
        cell.configureCell(headlines: self.data.value[indexPath.row])
        return cell
    }
}
