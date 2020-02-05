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
    @IBOutlet weak var basket: Basket!
    
    var categories: [Categories] = []
    var selectedRow = Int()
    var productsCount = RealmDataBase.shared.getSavedProducts().count

    override func viewDidLoad() {
        super.viewDidLoad()

        CategoriesLoader().loadCategories { categories in
            self.categories = categories
            self.categoriesTableView.reloadData()
        }
        
        basket.setProductCount(productCount: RealmDataBase.shared.getSavedProducts().count)
    }
    
    @IBAction func showBasketViewController(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "fromViewController", sender: self.basket)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, BasketViewControllerDelegate, SubcategoriesViewControllerDelegate {
    func passProductsCount(productCount: Int) {
        self.productsCount = productCount
        basket.setProductCount(productCount: productCount)
    }
    
    func getProductsCount(productCount: Int) {
        basket.setProductCount(productCount: productCount)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell") as! CategoriesTableViewCell
        
        cell.titleLabel.text = categories[indexPath.row].name
        
        cell.categoriesImage.setImage(url: "http://blackstarshop.ru/\(categories[indexPath.row].iconImage)")
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let subcategoriesController = segue.destination as? SubcategoriesViewController, segue.identifier == "ShowSubcategories" {
            subcategoriesController.subcategories = self.categories[selectedRow]
            subcategoriesController.delegate = self
        }
        
        if let basketViewController = segue.destination as? BasketViewController, segue.identifier == "fromViewController" {
            basketViewController.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        categoriesTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowSubcategories", sender: indexPath)
    }
    
}

extension UIImageView {
    func setImage(url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
