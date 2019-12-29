//
//  CategoriesTableViewCell.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 28.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoriesImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
