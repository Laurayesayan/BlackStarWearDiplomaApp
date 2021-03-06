//
//  CategoriesLoader.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 27.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class CategoriesLoader {
    func loadCategories(getLoadedCategories: @escaping ([Categories]) -> Void) {
        SVProgressHUD.setForegroundColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        SVProgressHUD.show()
        AF.request("http://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON {
            response in
            if let json = response.value,
                let jsonDict = json as? NSDictionary {
                var categoriesList: [Categories] = []
                for (_, data) in jsonDict {
                    if let categories = Categories(data: data as! NSDictionary) {
                        categoriesList.append(categories)
                    }
                }

                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    getLoadedCategories(categoriesList)
                }
            }
        }
    }
    
    func loadProductsList(id: String, getLoadedProductsList: @escaping ([ProductsList]) -> Void) {
        SVProgressHUD.show()
        AF.request("http://blackstarshop.ru/index.php?route=api/v1/products&cat_id=\(id)").responseJSON {
            response in
            if let json = response.value,
                let jsonDict = json as? NSDictionary {
                var productsList: [ProductsList] = []
                for (_, data) in jsonDict {
                    if let products = ProductsList(data: data as! NSDictionary) {
                        productsList.append(products)
                    }
                }

                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    getLoadedProductsList(productsList)
                }
            }
        }
    }
    
}
