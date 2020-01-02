//
//  CategoriesLoader.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 27.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import Foundation
import Alamofire

class CategoriesLoader {
    func loadCategories(getLoadedCategories: @escaping ([Categories]) -> Void) {
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
                    getLoadedCategories(categoriesList)
                }
            }
        }
    }
    
    func loadProductsList(id: String, getLoadedProductsList: @escaping ([ProductsList]) -> Void) {
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
                    getLoadedProductsList(productsList)
                }
            }
        }
    }
}
    
//    func loadSubcategories(getLoadedSubcategories: @escaping ([Subcategories]) -> Void) {
//        AF.request("http://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON {
//            response in
//            if let json = response.value,
//                let jsonDict = json as? NSDictionary {
//                var subcategoriesList: [Subcategories] = []
//
//                for (_, data) in jsonDict {
//                    let dictData = data as! NSDictionary
//                    if let dictData = dictData["subcategories"] {
//                        for subdata in dictData as! NSArray {
//                            if let subcategories = Subcategories(data: subdata as! NSDictionary) {
//                                subcategoriesList.append(subcategories)
//                            }
//                        }
//                    }
//
//                }
//
//                DispatchQueue.main.async {
//                    getLoadedSubcategories(subcategoriesList)
//                }
//            }
//        }
//
//    }

