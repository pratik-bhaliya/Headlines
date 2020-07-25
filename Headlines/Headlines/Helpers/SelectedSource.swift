//
//  SelectedSource.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation

// MARK: - Singleton saving session source
struct SelectedSource {
    private init() { }
    static var shared = SelectedSource()
    var collectionArray:[String] = []
}
