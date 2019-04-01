//
//  ReviewViewController.swift
//  ReviewPageSample
//
//  Created by Hanif Salafi on 01/04/19.
//  Copyright © 2019 Ursabyte. All rights reserved.
//

import UIKit

protocol ReviewDataDelegate {
    func onSendData(reviewModel: ReviewModel)
}

class ReviewViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var bookingId: UILabel!
    
    @IBOutlet weak var rateHappiness: RatingController!
    @IBOutlet weak var rateCleanliness: RatingController!
    @IBOutlet weak var rateService: RatingController!
    @IBOutlet weak var rateSafety: RatingController!
    @IBOutlet weak var commentField: UITextView!
    @IBOutlet weak var characterCount: UILabel!
    
    var reviewModel: ReviewModel?
    var delegate: ReviewDataDelegate?
    var placeholderText = "You can give your comment in english or bahasa to share with other parents"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCommentField()
        initData()
    }
    
    func initData(){
        bookingId.text = reviewModel?.id
        productName.text = reviewModel?.nameProduct
        rateHappiness.starsRating = reviewModel?.rateHappiness ?? 0
        rateCleanliness.starsRating = reviewModel?.rateCleanliness ?? 0
        rateService.starsRating = reviewModel?.rateService ?? 0
        rateSafety.starsRating = reviewModel?.rateSafety ?? 0
    }
    
    func isValidate() -> Bool{
        if rateHappiness.starsRating != 0 && rateCleanliness.starsRating != 0 && rateService.starsRating != 0 && rateSafety.starsRating != 0 && (commentField.text != "" && commentField.text != placeholderText) {
            return true
        } else {
            return false
        }
    }

    @IBAction func submitReview(_ sender: Any) {
        if isValidate() {
            reviewModel?.rateHappiness = rateHappiness.starsRating
            reviewModel?.rateCleanliness = rateCleanliness.starsRating
            reviewModel?.rateService = rateService.starsRating
            reviewModel?.rateSafety = rateSafety.starsRating
            reviewModel?.comment = commentField.text
            
            // Data Review Model Ini Bisa Disimpan Ke Dalam Database
            
            if let model = reviewModel {
                delegate?.onSendData(reviewModel: model)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setupCommentField(){
        commentField.textColor = (reviewModel?.comment == "") ? UIColor.lightGray : UIColor.black
        commentField.text = (reviewModel?.comment == "") ? placeholderText : reviewModel?.comment
        commentField.returnKeyType = .done
        commentField.delegate = self
        
        characterCount.text = "\(reviewModel?.comment?.count ?? 0)/1000"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        var userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.6, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                let offset = CGPoint(x: 0, y: keyboardFrame.size.height+20)
                self.scrollView.contentOffset = offset
            }, completion: nil)
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let offset = CGPoint(x: 0, y: 0)
        self.scrollView.setContentOffset(offset, animated: true)
    }
}

extension ReviewViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
        }
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        characterCount.text = "\(numberOfChars)/1000"
        return numberOfChars <= 1000
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
    
}
