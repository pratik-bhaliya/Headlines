//
//  SavedViewModel.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation

final class SavedViewModel {
    // MARK: -  Instant Properties
    weak var dataSource : GenericDataSource<SavedArticle>?
    private var realMViewModel: RealMViewModel?
    
    init(dataSource: GenericDataSource<SavedArticle>?, realVM: RealMViewModel = RealMViewModel()) {
        self.dataSource = dataSource
        self.realMViewModel = realVM
    }
    
    // Fetch records from database
    func fetchRecord() {
        self.realMViewModel?.delegate = self
        realMViewModel?.fetchObjects()
    }
}

extension SavedViewModel: RealMViewModelDelegate {
    // Assigned fetched record to datasource
    func objectFetched(_ headlines: [SavedArticle]) {
        self.dataSource?.data.value.removeAll()
        if headlines.count > 0 {
            headlines.forEach { self.dataSource?.data.value.append($0) }
        }
    }
}
