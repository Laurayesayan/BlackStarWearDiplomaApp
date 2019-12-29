//
//  ViewController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 27.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    var categories: [Categories] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        CategoriesLoader().loadCategories { categories in
            self.categories = categories
            self.categoriesTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.categories.count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell") as! CategoriesTableViewCell
        
        cell.titleLabel.text = categories[indexPath.row].name
//        cell.titleLabel.text = categories[indexPath.section].name
        
        let url = URL(string: "http://blackstarshop.ru/\(categories[indexPath.row].iconImage)")
//        let url = URL(string: "http://blackstarshop.ru/\(categories[indexPath.section].iconImage)")
        let data = try? Data(contentsOf: url!)
        cell.categoriesImage.image = UIImage(data: data!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowSubcategories", sender: nil)
    }
    
    
}
