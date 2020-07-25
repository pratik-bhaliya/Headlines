//
//  NewsHeadlineCell.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit

final class NewsHeadlineCell: UITableViewCell {
    
    // MARK: - IBOutlet connection
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineTitle: UILabel!
    @IBOutlet weak var headlineSubtitle: UILabel!
    @IBOutlet weak var headlineAuthor: UILabel!
    @IBOutlet weak var backView: UIView!
    
    // MARK: - Instant property
    var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    // MARK: - Class
   fileprivate func setupCell() {
        self.backView.layer.cornerRadius = 10.0
        self.backView.layer.masksToBounds = true
        if #available(iOS 13.0, *) {
            self.contentView.layer.borderWidth = 0.2
            self.contentView.layer.borderColor = UIColor.label.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor ]
        headlineImageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func configureCell(headlines: Article) {
        headlineTitle.text = headlines.title
        headlineSubtitle.text = headlines.articleDescription
        headlineAuthor.text = headlines.author
        
        if let url = headlines.urlToImage {
            headlineImageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
        }
        
    }
    
    func configureSavedCell(article: SavedArticle) {
        headlineTitle.text = article.title
        headlineSubtitle.text = article.articleDescription
        headlineAuthor.text = article.author
        headlineImageView.loadImageUsingCacheWithURLString(article.urlToImage, placeHolder: UIImage(named: "placeholder"))
    }
    
}
