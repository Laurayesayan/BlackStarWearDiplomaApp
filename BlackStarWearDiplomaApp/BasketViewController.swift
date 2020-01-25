//
//  BasketViewController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 25.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {
    @IBOutlet weak var orderButton: UIView!
    @IBOutlet weak var orderButtonLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabelProperties()
        orderButton.layer.cornerRadius = 24
        setOrderButtonLabelProperties()
        setResultLabelProperties()
        setTotalMoneyLabelProperties()

    }
    
    func setTitleLabelProperties() {
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)

        titleLabel.textAlignment = .center
        titleLabel.attributedText = NSMutableAttributedString(string: "Корзина", attributes: [NSAttributedString.Key.kern: 0.19])
    }
    
    func setOrderButtonLabelProperties() {
        orderButtonLabel.textAlignment = .center
        orderButtonLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        orderButtonLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 15)
    }
    
    func setResultLabelProperties() {
        resultLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        resultLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        resultLabel.textAlignment = .left
        resultLabel.attributedText = NSMutableAttributedString(string: "Итого:", attributes: [NSAttributedString.Key.kern: 0.19])
    }
    
    func setTotalMoneyLabelProperties() {
        totalMoneyLabel.alpha = 0.4
        totalMoneyLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        totalMoneyLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        totalMoneyLabel.textAlignment = .right
        totalMoneyLabel.attributedText = NSMutableAttributedString(string: "2500 руб.", attributes: [NSAttributedString.Key.kern: 0.19])
    }
    
    @IBAction func closeBasketView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell") as! BasketTableViewCell
        
        return cell    }
    

    
}
