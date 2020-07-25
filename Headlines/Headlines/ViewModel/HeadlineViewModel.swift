//
//  HeadlineViewModel.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation


final class HeadlineViewModel {
    
    // MARK: -  Instant Properties
    weak var dataSource : GenericDataSource<Article>?
    weak var networkService: NetworkServiceProtocol?
    var onErrorHandling : ((NetworkError?) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkManager.shared, dataSource: GenericDataSource<Article>?) {
        self.dataSource = dataSource
        self.networkService = networkService
    }
    
    func getTopHeadlines() {
        NetworkManager.shared.get(with: .topHeadline, responseType: TopHeadlines.self) { [weak self] (response, error) in
            
            guard let self = self else { return } // weak returns a optional so we guard
            
            guard error == nil else {
                self.onErrorHandling?(error)
                return
            }
            
            response?.articles?.forEach { self.dataSource?.data.value.append($0)}
        }
    }
    
    func getTopHeadlinesBySource() {
        self.dataSource?.data.value.removeAll()
        globalArray.shared.collectionArray.forEach {
            NetworkManager.shared.get(with: .topHeadlineBySource(sourceName: $0.replacingOccurrences(of: " ", with: "-")), responseType: TopHeadlines.self) { [weak self] (response, error) in
                
                guard let self = self else { return } // weak returns a optional so we guard
                
                guard error == nil else {
                    self.onErrorHandling?(error)
                    return
                }
                response?.articles?.forEach { self.dataSource?.data.value.append($0)}
            }
        }
    }
}
