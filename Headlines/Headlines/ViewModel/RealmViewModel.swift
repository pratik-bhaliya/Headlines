//
//  RealmViewModel.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: DB Protocol Methods

protocol RealMViewModelDelegate {
    func recordSaved()
    func recordSavingFailed(error: NSError)
    func recordFetched(headlines: [Article])
    func recordDeleted()
}

// Make RealMViewModelDelegate methods optionals
extension RealMViewModelDelegate {
    func recordSaved() {}
    func recordSavingFailed(error: NSError) {}
    func recordFetched(headlines: [Article]) {}
    func recordDeleted() {}
}

class RealMViewModel: NSObject {
    
    let realm = try! Realm()
    var delegate: RealMViewModelDelegate?
    
    // MARK: DB Helper Methods
    
    func saveRecords(article: Article) {
        try! realm.write {
            realm.add(article)
            delegate?.recordSaved() // Notify for article successful insertion
        }
    }
    
    func fetchRecords() {
        let fetchedArticle = realm.objects(Article.self)
        if fetchedArticle.count > 0 {
            var fetchedArticles = [Article]()
            for article in fetchedArticle {
                fetchedArticles.append(article)
            }
            delegate?.recordFetched(headlines: fetchedArticles)
        } else {
            delegate?.recordFetched(headlines: [])
        }
    }
    
    func deleteRecords(headline: Article) {
        // Persist your data easily
        try! realm.write {
            realm.delete(headline)
            delegate?.recordDeleted() // Notify successfully deleted
        }
    }
    
}
