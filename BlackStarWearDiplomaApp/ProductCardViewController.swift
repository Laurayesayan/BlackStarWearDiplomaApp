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

    private var currentImage = String()
    private var currentImageIndex = Int()
    
    var sizeAndColorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        
//        productImagesPageControl.numberOfPages = 5
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            if sender.direction == .left {
                self.productImageView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                productImagesPageControl.currentPage += 1
            } else {
                self.productImageView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                productImagesPageControl.currentPage -= 1
            }
        }
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
