//
//  SizeAndColorViewController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 23.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

class SizeAndColorViewController: UIViewController {
    @IBOutlet weak var sizeAndColorTableView: UITableView!
    var selectedRow = -1
    var productInfo = ProductsList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(productInfo.name)
    }
}

extension SizeAndColorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productInfo.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sizeAndColorTableView.dequeueReusableCell(withIdentifier: "SizeAndColorViewCell", for: indexPath) as! SizeAndColorTableViewCell
        
        cell.colorLabel.text = productInfo.colorName
        
        if(indexPath.row == selectedRow) {
            cell.tickImageView.isHidden = false
        } else {
            cell.tickImageView.isHidden = true
        }
        
        cell.sizeLabel.text = productInfo.offers[indexPath.row].size
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sizeAndColorTableView.deselectRow(at: indexPath, animated: true)
        selectedRow = indexPath.row
        sizeAndColorTableView.reloadData()
    }
    
}

class SizeAndColorTableViewCell: UITableViewCell {
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var tickImageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
}
