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
    @IBOutlet weak var blindView: UIView!
    
   
    var product = ProductsList()
    private var dataImages = [Data]()
    private var currentImageIndex = 0
    var chosenSize = ProductsList.Offers()
    var isSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInitialScreen()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    @IBAction func showBasketView(_ sender: Any) {
        performSegue(withIdentifier: "ShowBasketView", sender:itemsInBuscketLabel)
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
        
        blindView.isHidden = true
    }
    
    func convertURLImageToData(URLImages: [String]) {
        dataImages = []
        for imageURL in product.productImages {
            let url = URL(string: "http://blackstarshop.ru/\(imageURL)")
            let data = try? Data(contentsOf: url!)
            
            dataImages.append(data!)
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sizeAndColor = segue.destination as? SizeAndColorViewController, segue.identifier == "ShowSizeAndColorView" {
            sizeAndColor.productInfo = self.product
            sizeAndColor.delegate = self
        }
        if let basketView = segue.destination as? BasketViewController, segue.identifier == "ShowBasketView" {
            if isSelected {
                var copyOfProduct = product
                copyOfProduct.offers = []
                copyOfProduct.offers.append(chosenSize)
                basketView.product = copyOfProduct
                isSelected = false
            }
        }
    }
    
    func showSizeAndColorView() {
        self.sizeAndColorView.isHidden = false
        self.blindView.isHidden = false
        self.sizeAndColorViewTopConstraint.constant = 18
        UIView.animate(withDuration: 0.65, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (True) in
        }

    }
    
    @IBAction func hideSizeAndColorViewGesture(_ sender: Any) {
        self.sizeAndColorViewTopConstraint.constant = self.view.frame.size.width
        UIView.animate(withDuration: 0.65, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (True) in
            self.sizeAndColorView.isHidden = true
        }
        
        self.blindView.isHidden = true
        
        if isSelected {
            performSegue(withIdentifier: "ShowBasketView", sender:itemsInBuscketLabel)
        }

    }
    
}

extension ProductCardViewController: SizeAndColorViewControllerDelegate {
    func getChosenSize(_ size: ProductsList.Offers) {
        self.chosenSize = size
        isSelected = true
    }
}
