//
//  ArticleTableViewCell.swift
//  NYT
//
//  Created by Madhur Mohta on 11/12/2017.
//

///Using subtitle cell for showing UI as all the UI elements fit appropriately for this cell

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        self.imageView?.layer.cornerRadius = 37
        self.imageView?.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureView(result: Results?) {
        fetchImage(url: result?.media?.first?.mediaMetadata?[1].url)
        self.textLabel?.text = result?.title ?? ""
        self.detailTextLabel?.attributedText = NYTUtilities.createAttributedString(byLine: result?.byline ?? "", publishedDate: result?.published_date ?? "")
    }
    
    /// In case of empty image returned by the closure
    /// We will show the default image
    
    func fetchImage(url: String?) {
        NYTUtilities.fetchImage(url: url) { (image) in
            self.imageView?.image = image ?? UIImage(named: "ico-default")
            self.layoutSubviews()
        }
    }
    
}
