//
//  String+Extensition.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 26/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
