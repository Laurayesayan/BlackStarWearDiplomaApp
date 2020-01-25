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
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setTitleLabelProperties() {
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        titleLabel.attributedText = NSMutableAttributedString(string: "Худи Aspen Gold", attributes: [NSAttributedString.Key.kern: 0.19])
    }
    
    func setSizeLabelProperties() {
        sizeLabel.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        sizeLabel.font = UIFont(name: "SFProDisplay-Medium", size: 11)
        sizeLabel.attributedText = NSMutableAttributedString(string: "Размер: S", attributes: [NSAttributedString.Key.kern: 0.13])
    }
    
    func setColorLabelProperties() {
        colorLabel.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        colorLabel.font = UIFont(name: "SFProDisplay-Medium", size: 11)
        colorLabel.attributedText = NSMutableAttributedString(string: " Цвет: белый", attributes: [NSAttributedString.Key.kern: 0.13])
    }
    
    func setTotalAmountLabelProperties() {
        totalAmountLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        totalAmountLabel.font = UIFont(name: "SFProDisplay-Medium", size: 15)

        totalAmountLabel.attributedText = NSMutableAttributedString(string: "2 500 руб.", attributes: [NSAttributedString.Key.kern: 0.18])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
