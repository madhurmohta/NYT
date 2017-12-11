//
//  NYTServiceManager.swift
//  NYT
//
//  Created by Madhur Mohta on 10/12/2017.
//

import UIKit

struct NYTServiceManager {
    
    /// Fetching Article List with the URL req and returning the Data obj in closure
    
    static func fetchArticlesList(_ completion:@escaping (Data?) -> ()) {
        guard let articlesListRequest = self.getURLRequest(String(format: ArticlesList.url, NYTRootModel.sharedInstance.pageIndex, kAPIKey)) else {completion(nil); return}
        self.performURLSessionForTaskForRequest(articlesListRequest, successBlock: { (responseData) in
            completion(responseData as? Data)
        }) { (error) in
            completion(nil)
        }
    }
    
    /// Generating URL Req for a valid url otherwise it returns nil

   static func getURLRequest(_ urlString: String) -> URLRequest? {
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            return urlRequest
        }
        return nil
    }
    
    /// Uses urlSession data task for fetching data
    /// Returns either a success or a error block

    static func performURLSessionForTaskForRequest(_ urlRequest: URLRequest, successBlock : @escaping ((AnyObject) -> Void), errorBlock: @escaping ((AnyObject) -> Void)) {
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                if let responseData = data {
                    successBlock(responseData as AnyObject)
                }
            } else {
                errorBlock(error! as AnyObject)
            }
        })
        task.resume()
    }

}
