//
//  RealmViewModel.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - DB Protocol Methods
protocol RealMViewModelDelegate {
    func recordSaved()
    func recordSavingFailed(error: NSError)
    func recordFetched(headlines: [SavedArticle])
    func recordDeleted()
}

// Make RealMViewModelDelegate methods optionals
extension RealMViewModelDelegate {
    func recordSaved() {}
    func recordSavingFailed(error: NSError) {}
    func recordFetched(headlines: [SavedArticle]) {}
    func recordDeleted() {}
}

final class RealMViewModel: NSObject {
    // MARK: -  Instant Properties
    let realm = try! Realm()
    var delegate: RealMViewModelDelegate?
    
    // MARK: -DB Helper Methods
    func saveRecords(article: SavedArticle) {
        try! realm.write {
            realm.add(article)
            delegate?.recordSaved() // Notify for article successful insertion
        }
    }
    
    func fetchRecords() {
        let fetchedArticle = realm.objects(SavedArticle.self)
        if fetchedArticle.count > 0 {
            var fetchedArticles = [SavedArticle]()
            fetchedArticle.forEach {fetchedArticles.append($0)}
            delegate?.recordFetched(headlines: fetchedArticles)
        } else {
            delegate?.recordFetched(headlines: [])
        }
    }
    
    func deleteRecords(headline: SavedArticle) {
        // Persist your data easily
        try! realm.write {
            realm.delete(headline)
            delegate?.recordDeleted() // Notify successfully deleted
        }
    }
    
}
