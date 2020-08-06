//
//  HeadlineViewModel.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation

struct HeadlineViewModel {
    
    // MARK: -  Instant Properties
    weak var dataSource : GenericDataSource<Article>?
    weak var networkService: NetworkServiceProtocol?
    var onErrorHandling : ((NetworkError?) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkManager.shared, dataSource: GenericDataSource<Article>?) {
        self.dataSource = dataSource
        self.networkService = networkService
    }
    
    // Get initial headlines
    func getTopHeadlines() {
        
        guard let service = networkService else {
            self.onErrorHandling?(.genericError)
            return
        }
        
        service.get(with: .topHeadline, responseType: TopHeadlines.self) { result in
            switch result {
            case .success(let articles):
                articles.articles?.forEach { self.dataSource?.data.value.append($0)}
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        }
    }
    
    // Get user selected sources headlines
    func getTopHeadlinesBySource() {
        self.dataSource?.data.value.removeAll()
        
        guard let service = networkService else {
            self.onErrorHandling?(.genericError)
            return
        }
        
        SelectedSource.shared.collectionArray.forEach {
            service.get(with: .topHeadlineBySource(sourceName: $0.replacingOccurrences(of: " ", with: "-")), responseType: TopHeadlines.self) { result in
                
                switch result {
                case .success(let articles):
                    articles.articles?.forEach { self.dataSource?.data.value.append($0)}
                case .failure(let error):
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
