//
//  NYTImageCache.swift
//  NYTimesClone
//
//  Created by Madhur Mohta on 10/12/2017.
//

import Foundation
import UIKit

/// Cache class to store images

class NYTImageCache  {
    
    private init() {}
    
    class var sharedInstance: NSCache<NSString, UIImage> {
        struct Singleton {
            static let instance = NSCache<NSString, UIImage>()
        }
        return Singleton.instance
    }
    
}
