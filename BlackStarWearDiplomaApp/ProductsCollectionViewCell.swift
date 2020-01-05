//
//  ProductsCollectionViewCell.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 02.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

class ProductsCollectionViewCell:
UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var buyButtonRectangle: UIView!
    override func layoutSubviews() {
        self.buyButtonRectangle.layer.cornerRadius = 5
    }
    
//    func showProductCard() {
//        performSegue(withIdentifier: "ShowProductCard", sender: Any.self)
//    }
}
