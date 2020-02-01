//
//  SubcategoriesViewController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 30.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import UIKit

class SubcategoriesViewController: UIViewController {
    
    var selectedID = String()
    
    @IBOutlet weak var subcategoriesTableView: UITableView!
    @IBOutlet weak var navigationItemTitle: UINavigationItem!
    @IBOutlet weak var basket: Basket!
    var productsCount = RealmDataBase.shared.getSavedProducts().count
    
    var subcategories = Categories()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        basket.setProductCount(productCount: productsCount)
    }
    
}

extension SubcategoriesViewController: UITableViewDelegate, UITableViewDataSource, BasketViewControllerDelegate, ProductsListViewControllerDelegate {
    func passProductsCount(productCount: Int) {
        basket.setProductCount(productCount: productCount)
    }
    
    func getProductsCount(productCount: Int) {
        basket.setProductCount(productCount: productCount)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subcategories.subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subcategoriesTableView.dequeueReusableCell(withIdentifier: "SubcategoriesCell") as! SubcategoriesTableViewCell
        
        cell.subcategoriesTitle.text = self.subcategories.subcategories[indexPath.row].name
        
        self.navigationItemTitle.title = self.subcategories.name
            
        if !self.subcategories.subcategories[indexPath.row].iconImage.isEmpty {
            let url = URL(string: "http://blackstarshop.ru/\(self.subcategories.subcategories[indexPath.row].iconImage)")
            
            let data = try? Data(contentsOf: url!)
            cell.subcategoriesImageView.image = UIImage(data: data!)
        } else {
            cell.subcategoriesImageView.image = UIImage(named: "NON")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productsController = segue.destination as? ProductsListViewController, segue.identifier == "ShowProductsList" {
            productsController.id = self.selectedID
            productsController.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        subcategoriesTableView.deselectRow(at: indexPath, animated: true)
        selectedID = self.subcategories.subcategories[indexPath.row].id
        performSegue(withIdentifier: "ShowProductsList", sender: indexPath)
    }
    
}
