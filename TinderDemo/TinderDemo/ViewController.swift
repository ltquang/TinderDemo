//
//  ViewController.swift
//  TinderDemo
//
//  Created by macOS on 9/16/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import UIKit
import TinderSwipeView

class ViewController: UIViewController {

    private var swipeView: TinderSwipeView<UserModel>! {
        didSet{
            self.swipeView.delegate = self
        }
    }
    
    let userModels : [UserModel] =  {
        var model : [UserModel] = []
        for n in 1...30 {
            let location = LocationModel(latitude: "83.5610",
                                         longitude: "22.7340",
                                         address: "ho chi minh, vn")
            model.append(UserModel(uuid: "1",
                                   name: "name",
                                   email: "email",
                                   dob: "1990-04-17T11:43:53.681Z",
                                   phone: "123-123",
                                   cell: "0987-387",
                                   picture: "https://randomuser.me/api/portraits/women/75.jpg",
                                   location: location))
        }
        return model
    }()
    @IBOutlet weak var viewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        let contentView: (Int, CGRect, UserModel) -> (UIView) = { (index: Int ,frame: CGRect , userModel: UserModel) -> (UIView) in
            let cardViewController = UIStoryboard(name: "CardViewController", bundle: nil).instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
            cardViewController.userModel = userModel
            cardViewController.view.translatesAutoresizingMaskIntoConstraints = false
            cardViewController.view.frame = CGRect(origin: .zero,
                                                   size: CGSize(width: self.viewContainer.bounds.width-20,
                                                                height: self.viewContainer.bounds.height-50))
            self.addChild(cardViewController)
            return cardViewController.view
        }
        
        swipeView = TinderSwipeView<UserModel>(frame: viewContainer.bounds, contentView: contentView)
        swipeView.sepeatorDistance = 0
        viewContainer.addSubview(swipeView)
        swipeView.showTinderCards(with: userModels ,isDummyShow: false)
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
        self.children.first?.removeFromParent()
    }
    
    func undoCardsDone(model: Any) {
        
    }
    
    func endOfCardsReached() {
        
    }
}
