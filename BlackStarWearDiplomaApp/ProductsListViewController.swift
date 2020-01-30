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
    var index = Int()
    var productsList: [ProductsList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        CategoriesLoader().loadProductsList(id: id) { productsList in
//            self.productsList = productsList
//            self.productsCollectionView.reloadData()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CategoriesLoader().loadProductsList(id: id) { productsList in
            self.productsList = productsList
            self.productsCollectionView.reloadData()
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
}

extension ProductsListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.size.width / 2
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCollectionViewCell

        cell.titleLabel.text = productsList[indexPath.row].name
        cell.descriptionLabel.text = productsList[indexPath.row].description
        cell.priceLabel.text = "\(round(Double(productsList[indexPath.row].price) ?? 0))"
        

        let url = URL(string: "http://blackstarshop.ru/\(productsList[indexPath.row].mainImage)")

        let data = try? Data(contentsOf: url!)
        cell.productImage.image = UIImage(data: data!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productCard = segue.destination as? ProductCardViewController, segue.identifier == "ShowProductCard" {
            productCard.product =  self.productsList[index]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "ShowProductCard", sender: indexPath)
    }
    
}
