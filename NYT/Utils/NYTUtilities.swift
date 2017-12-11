//
//  NYTUtilities.swift
//  NYTimesClone
//
//  Created by Madhur Mohta on 10/12/2017.
//

import UIKit

let newLine: String = "\n"

///Utils struct to for commons accessed functions

struct NYTUtilities {

    static func displayError(errorMessage: String, errorTitle: String, view: UIViewController) {
        let alertController: UIAlertController = UIAlertController(title: errorTitle.localized, message: errorMessage.localized, preferredStyle: .alert)
        let closeAction: UIAlertAction = UIAlertAction(title: "OK".localized, style: .cancel) { action -> Void in
        }
        alertController.addAction(closeAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    /// Will check if the image is in Cache otherwise it will fetch and add in Cache
    /// Invalid URL causes an empty UIImage to be returned
    
    static func fetchImage(url: String?, completion: @escaping (UIImage?) -> ()) {
        
        if let cachedImage = NYTImageCache.sharedInstance.object(forKey: url as NSString? ?? "") {
            completion(cachedImage)
        } else {
            if let urlObj = URL(string: url ?? "") {
                let task = URLSession.shared.dataTask(with: urlObj) { (data, response, error) in
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            NYTImageCache.sharedInstance.setObject(image, forKey: (url as NSString?) ?? "")
                            DispatchQueue.main.async {
                                completion(image)
                            }
                        } else {
                            completion(nil)
                        }
                    }
                }
                task.resume()
            } else {
                completion(nil)
            }
        }
    }
    /// Creating attributed string for the detailed Text label in cell
    /// Appending the published date to the string as per UI
    /// If icon is available we can add text attachment
    
    static func createAttributedString(byLine: String, publishedDate: String) -> NSAttributedString {
        let publishedDateAttributed = NSAttributedString(string: publishedDate, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        let byLineAttributed = NSMutableAttributedString(string: byLine, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        byLineAttributed.append(NSAttributedString(string: newLine))
        byLineAttributed.append(publishedDateAttributed)
        return byLineAttributed
    }
    
    static func isConnectedToNetwork() -> Bool {
        let connectionTuple = Reachability.isConnectedToNetwork()
        return connectionTuple.0
    }
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
