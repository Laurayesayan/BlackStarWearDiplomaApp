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

struct ProductsList {
    let name: String
    //    let englishName: String
    //    let sortOrder: String
    //    let article: String
    let description: String
    let colorImageURL: String
    let mainImage: String
    let price: String
    let colorName: String
    var productImages: [String] = []
    var offers: [Offers] = []
    var isEmpty = true
    
    struct Offers {
        let size: String
        let quantity: String
        let productOfferID: String
        
        init?(data: NSDictionary) {
            guard let size = data["size"] as? String,
                let quantity = data["quantity"] as? String,
                let productOfferID = data["productOfferID"] as? String else {
                    return nil
            }
            
            self.size = size
            self.quantity = quantity
            self.productOfferID = productOfferID
        }
        
        init() {
            self.size = ""
            self.quantity = ""
            self.productOfferID = ""
        }
        
        init(size: String, quantity: String, productOfferID: String) {
            self.productOfferID = productOfferID
            self.quantity = quantity
            self.size = size
        }
    }
    
    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
            let description = data["description"] as? String,
            let colorImageURL = data["colorImageURL"] as? String,
            let mainImage = data["mainImage"] as? String,
            let colorName = data["colorName"] as? String,
            let price = data["price"] as? String else {
                return nil
        }
        
        for image in data["productImages"] as! NSArray {
            if let productImage = image as? NSDictionary {
                productImages.append(productImage["imageURL"] as! String)
            }
        }
        
        for subdata in data["offers"] as! NSArray {
            if let offer = Offers(data: subdata as! NSDictionary) {
                self.offers.append(offer)
            }
        }
        
        self.name = name
        self.description = description
        self.colorImageURL = colorImageURL
        self.mainImage = mainImage
        self.price = price
        self.colorName = colorName
        self.isEmpty = false
    }
    
    init() {
        self.name = ""
        self.description = ""
        self.colorImageURL = ""
        self.mainImage = ""
        self.price = ""
        self.colorName = ""
    }
    
    init(quantity: String, titleLabel: String, sizeLabel: String, colorLabel: String, priceLabel: String, productOfferID: String, image: String) {
        self.offers = [Offers(size: sizeLabel, quantity: quantity, productOfferID: productOfferID)]
        
        self.description = ""
        self.colorImageURL = ""
        self.name = titleLabel
        self.mainImage = image
        self.colorName = colorLabel
        self.price = priceLabel
        self.isEmpty = false
    }
}
