//
//  CustomAlertController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 30.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

struct AlertButton {
    var title: String!
    var action: (() -> Void)? = nil
    var titleColor: UIColor?
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
}

struct AlertPayload {
    var title: String!
    var titleColor: UIColor?
    var backgroundColor: UIColor?
    var message: String!
    var messageColor: UIColor?
    var buttons: [AlertButton]!
}

class CustomAlertController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    var payload: AlertPayload!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.text = payload.message
        
        createButton(uiButton: firstButton, alertButton: payload.buttons[0])
        createButton(uiButton: secondButton, alertButton: payload.buttons[1])
        
        if payload.backgroundColor != nil {
            view.backgroundColor = payload.backgroundColor
        }
    }
    
    @IBAction func firstButton(_ sender: Any) {
        parent?.dismiss(animated: false, completion: nil)
        payload.buttons.first?.action?()
    }
    @IBAction func secondButton(_ sender: Any) {
        parent?.dismiss(animated: false, completion: nil)
        payload.buttons[1].action?()
    }
    
    private func createButton(uiButton: UIButton, alertButton: AlertButton) {
        uiButton.setTitle(alertButton.title, for: .normal)
        
        if alertButton.titleColor != nil {
            uiButton.setTitleColor(alertButton.titleColor, for: .normal)
        }
        
        if alertButton.backgroundColor != nil {
            uiButton.backgroundColor = alertButton.backgroundColor
        }
        
        if alertButton.cornerRadius != nil {
            uiButton.layer.cornerRadius = alertButton.cornerRadius!
        }
    }
    
}

class CustomAlertInstantiator {
    func showAlert(payload: AlertPayload, parentViewController: UIViewController) {
        var customAlertController: CustomAlertController!
        customAlertController = self.instantiateViewController(storyboardName: "Main", viewControllerIdentifier: "CustomAlert") as? CustomAlertController
        
        customAlertController?.payload = payload
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.setValue(customAlertController, forKey: "contentViewController")
        parentViewController.present(alertController, animated: true, completion: nil)
    }
    
    
    public func instantiateViewController(storyboardName: String, viewControllerIdentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
    }
}
