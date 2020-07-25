//
//  SourcesTableViewCell.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit

class SourcesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var sourceName: UILabel!
    
    @IBOutlet weak var sourceDescription: UILabel!
    @IBOutlet weak var sourceCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        self.backView.layer.cornerRadius = 10.0
        self.backView.layer.masksToBounds = true
        if #available(iOS 13.0, *) {
            self.contentView.layer.borderWidth = 0.2
            self.contentView.layer.borderColor = UIColor.label.cgColor
        }
    }
    
    func configureCell(_ source: Source) {
        sourceName.text = source.name
        sourceDescription.text = source.sourceDescription
        sourceCategory.text = source.category.rawValue
    }
    
}
