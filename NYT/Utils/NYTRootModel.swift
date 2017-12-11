//
//  NYTRootModel.swift
//  NYTimesClone
//
//  Created by Madhur Mohta on 10/12/2017.
//

import UIKit

class NYTRootModel {
    
    class var sharedInstance: NYTRootModel {
        struct Singleton {
            static let instance = NYTRootModel()
        }
        return Singleton.instance
    }
    
    
    var pageIndex = "7"
    var baseModel: Base?
    var selectedURL: String?
}
