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
}
