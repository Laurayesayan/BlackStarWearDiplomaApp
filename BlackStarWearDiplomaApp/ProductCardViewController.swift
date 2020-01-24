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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonTextLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var basketProductsCount: UIView!
    @IBOutlet weak var itemsInBuscketLabel: UILabel!
    @IBOutlet weak var sizeAndColorViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sizeAndColorView: UIView!
    
   
    var product = ProductsList()
    private var dataImages = [Data]()
    private var currentImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInitialScreen()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    func showInitialScreen() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        
        titleLabel.text = product.name
        
        priceLabel.font = UIFont(name: "HelveticaNeueCyr-Bold", size: 17)
        priceLabel.alpha = 0.5
        priceLabel.text = product.price + " ₽"
        
        buttonView.layer.cornerRadius = 10

        buttonTextLabel.attributedText = NSMutableAttributedString(string: "ДОБАВИТЬ В КОРЗИНУ", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        buttonTextLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        buttonTextLabel.textAlignment = .center
        
        convertURLImageToData(URLImages: product.productImages)
        productImagesPageControl.numberOfPages = dataImages.count
        productImageView.image = UIImage(data: dataImages[currentImageIndex])
        
        textView.text = product.description
        
        basketProductsCount.layer.cornerRadius = basketProductsCount.frame.size.width / 2
        
        itemsInBuscketLabel.textColor = .white
        
        sizeAndColorViewTopConstraint.constant = self.view.frame.height
        sizeAndColorView.isHidden = true
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
    @IBAction func pushButtonGesture(_ sender: Any) {
        showSizeAndColorView()
    }
    
    func showSizeAndColorView() {
        self.sizeAndColorView.isHidden = false
        self.sizeAndColorViewTopConstraint.constant = 18
        UIView.animate(withDuration: 0.65, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (True) in
        }
    }

}
