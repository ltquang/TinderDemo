//
//  ViewController.swift
//  TinderDemo
//
//  Created by macOS on 9/16/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import UIKit
import TinderSwipeView
import Alamofire

class ViewController: UIViewController {

    private var swipeView: TinderSwipeView<UserModel>! {
        didSet{
            self.swipeView.delegate = self
        }
    }
    
    @IBOutlet weak var loadMoreButton: UIButton!
    var httpService: HttpServiceProtocol? = nil
    var userModels : [UserModel] = []
    var favorites : [UserModel] = [] {
        didSet {
            print("favorite changed")
        }
    }
    @IBOutlet weak var viewContainer: UIView!

    override func viewDidAppear(_ animated: Bool) {
        httpService?.getUser(callBack: callbackGetUsers)
    }
    
    lazy var callbackGetUsers:(([String: Any]?) -> Void) = { (response) -> Void in
        if let results = response?["results"] as? [[String: Any]] {
            self.userModels.removeAll()
            for result in results {
                self.userModels.append(UserModel(json: result))
            }
            self.renderCards()
        }
    }
    
    lazy var contentView: (Int, CGRect, UserModel) -> (UIView) = { (index: Int ,frame: CGRect , userModel: UserModel) -> (UIView) in
        let cardViewController = UIStoryboard(name: "CardViewController", bundle: nil).instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
        cardViewController.userModel = userModel
        cardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        cardViewController.view.frame = CGRect(origin: .zero,
                                               size: CGSize(width: self.viewContainer.bounds.width-20,
                                                            height: self.viewContainer.bounds.height-50))
        self.addChild(cardViewController)
        return cardViewController.view
    }
    
    func renderCards() {
        if swipeView != nil {
            swipeView.removeFromSuperview()
        }
        loadMoreButton.isHidden = true
        swipeView = TinderSwipeView<UserModel>(frame: viewContainer.bounds, contentView: contentView)
        swipeView.sepeatorDistance = 0
        viewContainer.addSubview(swipeView)
        swipeView.showTinderCards(with: userModels ,isDummyShow: false)
    }
    
    @IBAction func touchLoadMore(_ sender: Any) {
        self.httpService?.getUser(callBack: callbackGetUsers)
    }
    
    @IBAction func touchOnFavorite(_ sender: Any) {
    }
}

extension ViewController: TinderSwipeViewDelegate {
    func dummyAnimationDone() {
        
    }
    
    func currentCardStatus(card: Any, distance: CGFloat) {
        
    }
    
    func fallbackCard(model: Any) {
        
    }
    
    func didSelectCard(model: Any) {
        
    }
    
    func cardGoesLeft(model: Any) {
        self.children.first?.removeFromParent()
    }
    
    func cardGoesRight(model: Any) {
        favorites.append(model as! UserModel)
        self.children.first?.removeFromParent()
    }
    
    func undoCardsDone(model: Any) {
        
    }
    
    func endOfCardsReached() {
        loadMoreButton.isHidden = false
        swipeView.removeFromSuperview()
    }
}
