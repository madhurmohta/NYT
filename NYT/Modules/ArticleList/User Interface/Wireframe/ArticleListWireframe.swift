//
//  NewsstandWireframe.swift
//  NYT
//
//  Created by Madhur Mohta on 10/12/2017.
//

import Foundation
import UIKit
import SafariServices

/// Routing Class for loading Safari VC for a particular URL

class ArticleListWireframe {
    
    func pushDetailsViewController(_ viewController: ArticleListViewController) {
        
        var safariVC : SFSafariViewController?
        if let url = URL(string: NYTRootModel.sharedInstance.selectedURL ?? "") {
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                safariVC = SFSafariViewController(url: url, configuration: config)
            } else {
                safariVC = SFSafariViewController(url: url)
            }
            viewController.present(safariVC!, animated: true, completion: nil)
        }
    }
}
