//
//  DataBase.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 26.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object {
    @objc dynamic var quantity = String()
    @objc dynamic var titleLabel = String()
    @objc dynamic var sizeLabel = String()
    @objc dynamic var colorLabel = String()
    @objc dynamic var priceLabel = String()
    @objc dynamic var productOfferID = String()
    @objc dynamic var image = String()
}

class RealmDataBase {
    static let shared = RealmDataBase()
    private var product = ProductsList()
    private var productsList: [ProductsList] = []
    
    private let realm = try! Realm()
    
    func setProduct(product: ProductsList) {
        self.product = product
    }
    
    func recordProduct() {
        try! realm.write {
            let currentProduct = Product()
            
            currentProduct.colorLabel = product.colorName
            currentProduct.priceLabel = product.price
            currentProduct.productOfferID = product.offers[0].productOfferID
            currentProduct.quantity = product.offers[0].quantity
            currentProduct.sizeLabel = product.offers[0].size
            currentProduct.titleLabel = product.name
            currentProduct.image = product.mainImage
            
            realm.add(currentProduct)
        }
    }
    
    func getSavedProducts() -> [ProductsList] {
        productsList = []
        
        for prod in realm.objects(Product.self) {
            productsList.append(ProductsList(quantity: prod.quantity, titleLabel: prod.titleLabel, sizeLabel: prod.sizeLabel, colorLabel: prod.colorLabel, priceLabel: prod.priceLabel, productOfferID: prod.productOfferID, image: prod.image))
        }
        
        return productsList.reversed()
    }
    
    func deleteAllProducts() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteProduct(id: String) {
        for prod in realm.objects(Product.self) {
            if id == prod.productOfferID {
                try! realm.write {
                    realm.delete(prod)
                }
            }
        }

        productsList = [] // may be fail
    }
    
    func isEmpty() -> Bool {
        return realm.objects(Product.self).isEmpty
    }
}
