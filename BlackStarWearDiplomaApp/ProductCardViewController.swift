//
//  ProductCardViewController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 05.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

class ProductCardViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productImagesPageControl: UIPageControl!

    var product = ProductsList()
    private var dataImages = [Data]()
//    private var currentImage = Data()
    private var currentImageIndex = 0
    
    //    var sizeAndColorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertURLImageToData(URLImages: product.productImages)
        productImagesPageControl.numberOfPages = dataImages.count
        productImageView.image = UIImage(data: dataImages[currentImageIndex])
    }
    
    func convertURLImageToData(URLImages: [String]) {
        dataImages = []
        for imageURL in product.productImages {
            let url = URL(string: "http://blackstarshop.ru/\(imageURL)")
            let data = try? Data(contentsOf: url!)
            
            dataImages.append(data!)
        }
        
//        cell.productImage.image = UIImage(data: data!)
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        if !dataImages.isEmpty {
            currentImageIndex = currentImageIndex > 0 ? currentImageIndex - 1 : 0
            self.productImageView.image = UIImage(data: dataImages[currentImageIndex])
            productImagesPageControl.currentPage -= 1
        }

    }
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        if !dataImages.isEmpty {
            currentImageIndex = currentImageIndex < (dataImages.count - 1) ? currentImageIndex + 1 : currentImageIndex
            self.productImageView.image = UIImage(data: dataImages[currentImageIndex])
            productImagesPageControl.currentPage += 1
        }

    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}



// Нужно будет после того, как закончу с карточкой товара.
//func showSizeAndColorView() {
//    UIView.animate(withDuration: 0.5, delay: 0.15, options: .curveEaseOut, animations: {
//        self.sizeAndColorView.center.y -= self.sizeAndColorView.frame.size.height
//
//    }, completion: { finished in
//
//    })
//
//}

//@IBAction func buyButton(_ sender: Any) {
//    self.sizeAndColorView.layer.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
//    self.sizeAndColorView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height / 2)
//    self.view.addSubview(self.sizeAndColorView)
//    showSizeAndColorView()
//}
