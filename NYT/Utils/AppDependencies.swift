//
//  AppDependencies.swift
//  NYT
//
//  Created by Madhur Mohta on 10/12/2017.
//

import Foundation



struct AppDependencies {
    
    static func configureArticleListView(_ viewController: ArticleListViewController) {
        
        let articleListWireframe = ArticleListWireframe()
        let articlePresenter = ArticleListPresenter()
        let articleInteractor = ArticleListInteractor()
        
        viewController.eventHandler = articlePresenter
        articlePresenter.userInterface = viewController
        articlePresenter.articleInteractor = articleInteractor
        articleInteractor.articlePresenter = articlePresenter
        articlePresenter.articleWireframe = articleListWireframe
        
    }
}
