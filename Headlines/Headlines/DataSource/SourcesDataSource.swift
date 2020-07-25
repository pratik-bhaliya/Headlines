//
//  SourcesDataSource.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit

final class SourceListDataSource : GenericDataSource<Source>, UITableViewDataSource {
    var selectedIndexPaths = Set<IndexPath>()

    // Number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    // Cell configuration and setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesTableViewCell") as! SourcesTableViewCell
        cell.configureCell(self.data.value[indexPath.row])
        return cell
    }
}

extension SourceListDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPaths.contains(indexPath) { //deselect
            selectedIndexPaths.remove(indexPath)
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            let selectedCell = self.data.value[indexPath.row]
            
            // Remove unselected sources
            for (index,value) in globalArray.shared.collectionArray.enumerated() {
                if value == selectedCell.name {
                    globalArray.shared.collectionArray.remove(at: index)
                }
            }
        }
        else{
            selectedIndexPaths.insert(indexPath) //select
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            // Add source to global array.
            globalArray.shared.collectionArray.append(self.data.value[indexPath.row].name)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = selectedIndexPaths.contains(indexPath) ? .checkmark : .none
    }
}


struct globalArray {

    private init() { }
    static var shared = globalArray()
    var collectionArray:[String] = []

}
