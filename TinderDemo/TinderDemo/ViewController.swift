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
    var httpService: HttpServiceProtocol!
    var favoriteManager: FavoriteManager!
    var userModels : [UserModel] = []
    
    @IBOutlet weak var viewContainer: UIView!

    @IBOutlet weak var favoriteLabel: UILabel!
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
        } else {
            self.showAlert(title: "Error", errorMsg: "Can not connect to server")
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
    
    func renderCards(showFavorite: Bool = false) {
        if swipeView != nil {
            swipeView.removeFromSuperview()
        }
        loadMoreButton.isHidden = true
        swipeView = TinderSwipeView<UserModel>(frame: viewContainer.bounds, contentView: contentView)
        swipeView.sepeatorDistance = 0
        viewContainer.addSubview(swipeView)
        swipeView.showTinderCards(with: showFavorite ? favoriteManager.getFavorite() : userModels ,isDummyShow: false)
    }
    
    func showAlert(title: String, errorMsg: String) {
        let alert = UIAlertController(title: title, message: errorMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func touchLoadMore(_ sender: Any) {
        favoriteLabel.isHidden = true
        self.httpService?.getUser(callBack: callbackGetUsers)
    }
    
    @IBAction func touchOnFavorite(_ sender: Any) {
        if favoriteManager.getFavorite().isEmpty {
            showAlert(title: "Favorite", errorMsg:
            "You don't have favorited data now")
        } else {
            favoriteLabel.isHidden = false
            renderCards(showFavorite: true)
        }
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
        if let user = model as? UserModel,
        favoriteManager.getFavorite().contains(user) {
            favoriteManager.removeFavorite(user: user)
        }
        self.children.first?.removeFromParent()
    }
    
    func cardGoesRight(model: Any) {
        if let user = model as? UserModel {
            favoriteManager.appendFavorite(user: user)
        }
        self.children.first?.removeFromParent()
    }
    
    func undoCardsDone(model: Any) {
        
    }
    
    func endOfCardsReached() {
        loadMoreButton.isHidden = false
        swipeView.removeFromSuperview()
    }
}
