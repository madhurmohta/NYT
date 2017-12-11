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
        
        if let url = URL(string: NYTRootModel.sharedInstance.selectedURL ?? "") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            viewController.present(vc, animated: true, completion: nil)
        }
    }
}
