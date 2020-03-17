//
//  BasketTableViewCell.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 25.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var buttonPressed : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleLabelProperties()
        setSizeLabelProperties()
        setColorLabelProperties()
        setPriceLabelProperties()
    }
    
    func setTitleLabelProperties() {
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        titleLabel.attributedText = NSMutableAttributedString(string: "Title", attributes: [NSAttributedString.Key.kern: 0.19])
    }
    
    func setSizeLabelProperties() {
        sizeLabel.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        sizeLabel.font = UIFont(name: "SFProDisplay-Medium", size: 11)
        sizeLabel.attributedText = NSMutableAttributedString(string: "Size", attributes: [NSAttributedString.Key.kern: 0.13])
    }
    
    func setColorLabelProperties() {
        colorLabel.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        colorLabel.font = UIFont(name: "SFProDisplay-Medium", size: 11)
        colorLabel.attributedText = NSMutableAttributedString(string: "Color", attributes: [NSAttributedString.Key.kern: 0.13])
    }
    
    func setPriceLabelProperties() {
        priceLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        priceLabel.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        priceLabel.attributedText = NSMutableAttributedString(string: "Price.", attributes: [NSAttributedString.Key.kern: 0.18])
    }
    
    
    @IBAction func deleteProduct(_ sender: UIButton) {
        buttonPressed()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
