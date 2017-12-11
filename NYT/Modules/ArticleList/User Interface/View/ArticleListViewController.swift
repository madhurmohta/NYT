//
//  ViewController.swift
//  NYT
//
//  Created by Madhur Mohta on 10/12/2017.
//

import UIKit


/// Main View Controller.
/// Uses `UITableViewDelegate` & UITableViewDataSource
/// inherits from - UIViewController
/// Logically grouping using extensions

class ArticleListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var eventHandler: ArticleListPresenterInterface?
    var results: Base?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData()
    }
    
    func fetchData() {
        if NYTUtilities.isConnectedToNetwork() {
            self.activityIndicator.startAnimating()
            self.eventHandler?.fetchPopularArticles()
        } else {
            NYTUtilities.displayError(errorMessage: "No Internet Message", errorTitle: "Network Unavailable", view: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ArticleListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as? ArticleTableViewCell
        let localObj = self.results?.results?[indexPath.row]
        cell?.configureView(result: localObj)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        NYTRootModel.sharedInstance.selectedURL = self.results?.results?[indexPath.row].url ?? ""
        self.eventHandler?.showArticleDetail(viewController: self)
    }
}

extension ArticleListViewController: ArticleListModuleInterface {
    
    func updateView() {
        self.activityIndicator.stopAnimating()
        if let result =  NYTRootModel.sharedInstance.baseModel {
            self.results = result
            self.tableView.isHidden = false
            self.tableView.reloadData()
        } else {
            NYTUtilities.displayError(errorMessage: "Server Error Message", errorTitle: "Server Error", view: self)
        }
    }
}
