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
    var selectedRow = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoriesLoader().loadCategories { categories in
            self.categories = categories
            self.categoriesTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell") as! CategoriesTableViewCell
        
        cell.titleLabel.text = categories[indexPath.row].name
        
        let url = URL(string: "http://blackstarshop.ru/\(categories[indexPath.row].iconImage)")
             
        let data = try? Data(contentsOf: url!)
        cell.categoriesImage.image = UIImage(data: data!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let subcategoriesController = segue.destination as? SubcategoriesViewController, segue.identifier == "ShowSubcategories" {
            subcategoriesController.subcategories = self.categories[selectedRow]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        categoriesTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowSubcategories", sender: indexPath)
    }
    
}
