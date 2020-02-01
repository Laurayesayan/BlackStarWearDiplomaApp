//
//  Basket.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 01.02.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

class Basket: UIView {
    var isSetuped = false
    private var basketImage = UIImageView()
    private var redIcon = UIView()
    private var countLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        basketImage.frame = CGRect(x: 7, y: 7.5, width: 60, height: 60)
        basketImage.contentMode = .scaleAspectFit
        basketImage.image = UIImage(named: "gray basket")
        
        redIcon.frame = CGRect(x: 50, y: 0, width: 25, height: 25)
        redIcon.backgroundColor = #colorLiteral(red: 0.8144509196, green: 0.008485931903, blue: 0.1088143513, alpha: 1)
        redIcon.layer.cornerRadius = redIcon.frame.width / 2
        
        countLabel.frame = CGRect(x: 2, y: 2, width: 21, height: 21)
        countLabel.textAlignment = .center
        countLabel.textColor = UIColor.white
        countLabel.font = UIFont(name: "HelveticaNeueCyr-Black", size: 11)
        
        redIcon.addSubview(countLabel)
        
        for view in [basketImage, redIcon] {
            self.addSubview(view)
        }
        
        if isSetuped {
            return
        }
        isSetuped = true
    }
    
    func setProductCount(productCount: Int) {
        if productCount > 0 {
            redIcon.isHidden = false
            countLabel.text = "\(productCount)"
        }
        else {
            redIcon.isHidden = true
            countLabel.text = ""
        }
    }

}
