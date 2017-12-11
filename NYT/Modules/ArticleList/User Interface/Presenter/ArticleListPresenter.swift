//
//  ArticleListPresenter
//  NYT
//
//  Created by Madhur Mohta on 10/12/2017.
//

import Foundation

///Handling UI interactions and updates and passes to Interactor

class ArticleListPresenter: ArticleListPresenterInterface {

    weak var userInterface: ArticleListModuleInterface?
    var articleInteractor: ArticleListInteractorInterface?
    var articleWireframe: ArticleListWireframe?

    
    func fetchPopularArticles() {
        self.articleInteractor?.fetchPopularArticles()
    }
    
    func refreshView() {
        self.userInterface?.updateView()
    }
    
    func showArticleDetail(viewController: ArticleListViewController) {
        articleWireframe?.pushDetailsViewController(viewController)
    }
}
