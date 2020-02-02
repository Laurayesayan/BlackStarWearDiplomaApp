//
//  ProductsListViewController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 02.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

protocol ProductsListViewControllerDelegate {
    func passProductsCount(productCount: Int)
}


class ProductsListViewController: UIViewController {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var basket: Basket!
    
    var id = String()
    var index = Int()
    var productsList: [ProductsList] = []
    var productsCount = RealmDataBase.shared.getSavedProducts().count
    var delegate: ProductsListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesLoader().loadProductsList(id: id) { productsList in
            self.productsList = productsList
            self.productsCollectionView.reloadData()
        }
        
        basket.setProductCount(productCount: productsCount)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.passProductsCount(productCount: productsCount)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    @IBAction func showBasket(_ sender: Any) {
        performSegue(withIdentifier: "FromProductListController", sender: self.basket)
    }
    
}

extension ProductsListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, ProductCardViewControllerDelegate, BasketViewControllerDelegate {

    func getProductsCount(productCount: Int) {
        self.productsCount = productCount
        basket.setProductCount(productCount: productCount)
    }
    
    func passProductsCount(productCount: Int) {
        self.productsCount = productCount
        basket.setProductCount(productCount: productsCount)
    }
    
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
            productCard.delegate = self
        }
        
        if let basketViewController = segue.destination as? BasketViewController, segue.identifier == "FromProductListController" {
            basketViewController.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "ShowProductCard", sender: indexPath)
    }
    
}
