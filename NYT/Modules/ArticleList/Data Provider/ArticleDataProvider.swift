//
//  ArticleDataProvider.swift
//  NYT
//
//  Created by Madhur Mohta on 10/12/2017.
//

import UIKit

struct ArticleDataProvider {
    
    static func fetchArticles(_ completion:@escaping (Base?)->()) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async { () -> Void in
            NYTServiceManager.fetchArticlesList { (responseData) in
                    if let data = responseData {
                        guard let baseModel = self.getParsedModel(responseData: data) else { completion(nil) ; return }
                        if baseModel.status == "OK" {
                            completion(baseModel)
                        }
                    } else {
                        completion(nil)
                    }
                }
                
        }
    }
    
    static func getParsedModel(responseData: Data) -> Base? {
        var baseModel: Base?
        do {
          baseModel = try JSONDecoder().decode(Base.self, from: responseData)
        } catch {
            print("Error")
        }
        return baseModel
    }
}
