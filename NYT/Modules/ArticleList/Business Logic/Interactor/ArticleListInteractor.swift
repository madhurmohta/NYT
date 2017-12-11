//
//  NewsstandInteractor.swift
//  NYT
//
//  Created by Madhur Mohta on 10/12/2017.
//

import Foundation

class ArticleListInteractor: NSObject, ArticleListInteractorInterface {
    
    weak var articlePresenter: ArticleListPresenterInterface?
    
    func fetchPopularArticles() {
        ArticleDataProvider.fetchArticles { [weak self] data in
            NYTRootModel.sharedInstance.baseModel = data 
            DispatchQueue.main.async {
                self?.articlePresenter?.refreshView()
            }
        }
    }
}
