//
//  Source.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation

struct SourceViewModel {
    // MARK: -  Instant Properties
    weak var dataSource : GenericDataSource<Source>?
    weak var networkService: NetworkServiceProtocol?
    var onErrorHandling : ((NetworkError?) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkManager.shared, dataSource: GenericDataSource<Source>?) {
        self.dataSource = dataSource
        self.networkService = networkService
    }
    
    // Get all english filtered sources
    func getSources() {
        guard let service = networkService else {
            self.onErrorHandling?(.genericError)
            return
        }
        
        service.get(with: .sources, responseType: NewsSource.self) { result in
            
            switch result {
            case .success(let source):
                source.sources.forEach { self.dataSource?.data.value.append($0)}
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        }
    }
}
