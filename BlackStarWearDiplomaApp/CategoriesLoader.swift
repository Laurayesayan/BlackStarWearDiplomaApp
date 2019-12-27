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
    func loadCategories() {
        AF.request("http://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON {
            response in
            if let json = response.value,
                let jsonDict = json as? NSDictionary {
                var categoriesList: [Categories] = []
                if let categories = Categories(data: jsonDict) {
                    categoriesList.append(categories)
                }
                
                print(categoriesList.count)
//                print(categoriesList[0].iconImage)
            }
        }
    }
}
