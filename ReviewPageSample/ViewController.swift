//
//  ViewController.swift
//  ReviewPageSample
//
//  Created by Hanif Salafi on 01/04/19.
//  Copyright © 2019 Ursabyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReviewDataDelegate {

    @IBOutlet weak var dataView: UITextView!
    var reviewModel: ReviewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewModel = ReviewModel(id: "12345", name: "Sensory Play", comment: "", rateHappiness: 0, rateCleanliness: 0, rateService: 0, rateSafety: 0)
        printOutAndShow()
    }

    @IBAction func showReview(_ sender: Any) {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewVC = mainStoryBoard.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        reviewVC.reviewModel = reviewModel
        reviewVC.delegate = self
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    func onSendData(reviewModel: ReviewModel) {
        self.reviewModel = reviewModel
        printOutAndShow()
    }
    
    func printOutAndShow(){
        var dataString = ""
        print("Data Berhasil Tersimpan :")
        if let model = reviewModel {
            dataString += "Id: "+model.id!+"\nNama: "+model.nameProduct!+"\n"
            dataString += "Rating: \n"
            dataString += "- Happiness: \(model.rateHappiness)\n"
            dataString += "- Cleanliness: \(model.rateCleanliness)\n"
            dataString += "- Service: \(model.rateService)\n"
            dataString += "- Safety: \(model.rateSafety)\n"
            dataString += "Komentar: \n"
            dataString += model.comment!+"\n"
            print(dataString)
            self.dataView.text = dataString
        }
        
        
    }
    
}

