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
    let sortOrder: String
    let image: String
    let iconImage: String
    let iconImageActive: String
    var subcategories: [Subcategories] = []

    struct Subcategories {
        let id: String
        let iconImage: String
        let sortOrder: String
        let name: String
        let type: String

        init?(data: NSDictionary) {
            guard let id = data["id"] as? String,
                let iconImage = data["iconImage"] as? String,
                let sortOrder = data["sortOrder"] as? String,
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
        
        init() {
            self.id = ""
            self.iconImage = ""
            self.sortOrder = ""
            self.name = ""
            self.type = ""
        }
    }

    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
            let sortOrder = data["sortOrder"] as? String,
            let image = data["image"] as? String,
            let iconImage = data["iconImage"] as? String,
            let iconImageActive = data["iconImageActive"] as? String else {
                return nil
        }
        
        for subdata in data["subcategories"] as! NSArray {
            if let subcategories = Subcategories(data: subdata as! NSDictionary) {
                self.subcategories.append(subcategories)
            }
        }

        self.name = name
        self.sortOrder = sortOrder
        self.image = image
        self.iconImage = iconImage
        self.iconImageActive = iconImageActive
    }
    
    init() {
        self.name = ""
        self.sortOrder = ""
        self.image = ""
        self.iconImage = ""
        self.iconImageActive = ""
    }

}
