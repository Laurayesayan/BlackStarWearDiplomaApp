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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SizeAndColorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sizeAndColorTableView.dequeueReusableCell(withIdentifier: "SizeAndColorViewCell", for: indexPath) as! SizeAndColorTableViewCell
        
        cell.colorLabel.text = "Gold"
        if(indexPath.row == selectedRow) {
            cell.tickImageView.isHidden = false
        } else {
            cell.tickImageView.isHidden = true
        }
        
        cell.sizeLabel.text = "extra large"
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
