//
//  ReviewModel.swift
//  ReviewPageSample
//
//  Created by Hanif Salafi on 01/04/19.
//  Copyright © 2019 Ursabyte. All rights reserved.
//

import Foundation


class ReviewModel {
    var id: String?
    var nameProduct: String?
    var comment: String?
    var rateHappiness: Int = 0
    var rateCleanliness: Int = 0
    var rateService: Int = 0
    var rateSafety: Int = 0
    
    
    required init(id: String, name: String, comment: String, rateHappiness: Int, rateCleanliness: Int, rateService: Int, rateSafety: Int) {
        self.id = id
        self.nameProduct = name
        self.comment = comment
        self.rateHappiness = rateHappiness
        self.rateCleanliness = rateCleanliness
        self.rateService = rateService
        self.rateSafety = rateSafety
    }
    
    
}
