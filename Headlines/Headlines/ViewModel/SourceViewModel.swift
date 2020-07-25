//
//  Source.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation

final class SourceViewModel {
    // MARK: -  Instant Properties
    weak var dataSource : GenericDataSource<Source>?
    weak var networkService: NetworkServiceProtocol?
    var onErrorHandling : ((NetworkError?) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkManager.shared, dataSource: GenericDataSource<Source>?) {
        self.dataSource = dataSource
        self.networkService = networkService
    }
    
    func getSources() {
        NetworkManager.shared.get(with: .sources, responseType: NewsSource.self) { [weak self] (response, error) in
            guard let self = self else { return } // weak returns a optional
            
            guard error == nil else {
                self.onErrorHandling?(error)
                return
            }
            response?.sources.forEach { self.dataSource?.data.value.append($0)}
        }
    }
}
