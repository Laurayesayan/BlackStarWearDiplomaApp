//
//  JSONStructure.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 27.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import Foundation

struct Categories {
    let name: String
    let sortOrder: Int64
    let image: String
    let iconImage: String
    let iconImageActive: String
    let subcategories: Subcategories
    
    struct Subcategories {
        let id: Int64
        let iconImage: String
        let sortOrder: Int64
        let name: String
        let type: String
        
        init?(data: NSDictionary) {
            guard let id = data["id"] as? Int64,
                let iconImage = data["iconImage"] as? String,
                let sortOrder = data["sortOrder"] as? Int64,
                let name = data["name"] as? String,
                let type = data["type"] as? String else {
                    return nil
            }
            
            self.id = id
            self.iconImage = iconImage
            self.sortOrder = sortOrder
            self.name = name
            self.type = type
        }
    }
    
    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
            let sortOrder = data["sortOrder"] as? Int64,
            let image = data["image"] as? String,
            let iconImage = data["iconImage"] as? String,
            let iconImageActive = data["iconImageActive"] as? String,
            let subcategories = Subcategories(data: data["subcategories"] as! NSDictionary) else {
                return nil
        }
        
        self.name = name
        self.sortOrder = sortOrder
        self.image = image
        self.iconImage = iconImage
        self.iconImageActive = iconImageActive
        self.subcategories = subcategories
    }
    
}
