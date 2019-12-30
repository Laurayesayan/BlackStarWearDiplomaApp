//
//  SubcategoriesViewController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 30.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import UIKit

class SubcategoriesViewController: UIViewController {
    
    @IBOutlet weak var subcategoriesTableView: UITableView!
    
    var subcategories = Categories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(subcategories.subcategories.count)
    }
}

extension SubcategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subcategories.subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subcategoriesTableView.dequeueReusableCell(withIdentifier: "SubcategoriesCell") as! SubcategoriesTableViewCell
        cell.subcategoriesTitle.text = self.subcategories.subcategories[indexPath.row].name
        
        let url = URL(string: "http://blackstarshop.ru/\(self.subcategories.subcategories[indexPath.row].iconImage)")
             
        let data = try? Data(contentsOf: url!)
        cell.subcategoriesImageView.image = UIImage(data: data!)
        
        return cell
    }
    
}
