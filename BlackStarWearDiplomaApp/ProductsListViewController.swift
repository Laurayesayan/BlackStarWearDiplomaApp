//
//  ProductsListViewController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 02.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    var id = String()
    var productsList: [ProductsList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesLoader().loadProductsList(id: id) { productsList in
            self.productsList = productsList
            self.productsCollectionView.reloadData()
        }
    }
}

extension ProductsListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCollectionViewCell

        cell.titleLabel.text = productsList[indexPath.row].name
        cell.priceLabel.text = productsList[indexPath.row].price //.filter {$0 != "."}

        let url = URL(string: "http://blackstarshop.ru/\(productsList[indexPath.row].mainImage)")

        let data = try? Data(contentsOf: url!)
        cell.productImage.image = UIImage(data: data!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.size.width / 2
        return CGSize(width: w, height: w)
    }
    
}
