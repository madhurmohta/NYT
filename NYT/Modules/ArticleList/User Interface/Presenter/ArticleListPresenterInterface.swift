//
//  ArticleListPresenterInterface.swift
//  NYT
//
//  Created by Madhur Mohta on 10/12/2017.
//

import Foundation

/// ArticleListPresenterInterface Protocol which the Present conforms to

protocol ArticleListPresenterInterface: class {
    
    func fetchPopularArticles()
    func refreshView()
    func showArticleDetail(viewController: ArticleListViewController)
}
