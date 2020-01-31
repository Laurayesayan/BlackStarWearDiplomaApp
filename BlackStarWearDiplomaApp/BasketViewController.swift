//
//  BasketViewController.swift
//  BlackStarWearDiplomaApp
//
//  Created by Лаура Есаян on 25.01.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

protocol BasketViewControllerDelegate {
    func getProductsCount(productCount: Int)
}

class BasketViewController: UIViewController {
    @IBOutlet weak var orderButton: UIView!
    @IBOutlet weak var orderButtonLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var basketTableView: UITableView!
    
    var productsInBusket = [ProductsList]()
    var product = ProductsList()
    var delegate: BasketViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabelProperties()
        orderButton.layer.cornerRadius = 24
        setOrderButtonLabelProperties()
        setResultLabelProperties()
        setTotalAmountLabelProperties()
        
        if !self.product.isEmpty {
            recordProduct()
        }
        
        updateProductsInBusket()
        calculateTotalAmount()
        
        basketTableView.allowsMultipleSelectionDuringEditing = true
        

    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    func removeProduct(productOfferID: String) {
        RealmDataBase.shared.deleteProduct(id: productOfferID)
    }
    
    func updateProductsInBusket() {
        productsInBusket = RealmDataBase.shared.getSavedProducts()
    }
    
    func recordProduct() {
        RealmDataBase.shared.setProduct(product: product)
        RealmDataBase.shared.recordProduct()
    }
    
    func setTitleLabelProperties() {
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)

        titleLabel.textAlignment = .center
        titleLabel.attributedText = NSMutableAttributedString(string: "Корзина", attributes: [NSAttributedString.Key.kern: 0.19])
    }
    
    func setOrderButtonLabelProperties() {
        orderButtonLabel.textAlignment = .center
        orderButtonLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        orderButtonLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 15)
    }
    
    func setResultLabelProperties() {
        resultLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        resultLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        resultLabel.textAlignment = .left
        resultLabel.attributedText = NSMutableAttributedString(string: "Итого:", attributes: [NSAttributedString.Key.kern: 0.19])
    }
    
    func setTotalAmountLabelProperties() {
        totalAmountLabel.alpha = 0.4
        totalAmountLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        totalAmountLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        totalAmountLabel.textAlignment = .right
        totalAmountLabel.attributedText = NSMutableAttributedString(string: "2500 руб.", attributes: [NSAttributedString.Key.kern: 0.19])
    }
    
    @IBAction func closeBasketView(_ sender: Any) {
        delegate?.getProductsCount(productCount: productsInBusket.count)
        dismiss(animated: true, completion: nil)
    }
    
    //    @IBAction func deleteProduct(_ sender: Any) {
//        basketTableView.isEditing = !basketTableView.isEditing
//        if let selectedRows = basketTableView.indexPathsForSelectedRows {
//            for indexPath in selectedRows {
//                print(indexPath)
//                RealmDataBase.shared.deleteProduct(id: productsInBusket[indexPath.row].offers[0].productOfferID)
//            }
//
////            RealmDataBase.shared.deleteProduct(id: productsInBusket[selectedRows)
//
//
////            var items: [String] = []
////            for indexPath in selectedRows  {
////                items.append(tasksList[indexPath.row])
////            }
//
////            for item in items {
////                if let index = tasksList.firstIndex(of: item) {
////                    removeTask(task: tasksList[index])
////                    tasksList.remove(at: index)
////                }
////            }
//
//            basketTableView.beginUpdates()
//            basketTableView.deleteRows(at: selectedRows, with: .automatic)
//            basketTableView.endUpdates()
//        }
//
//        updateProductsInBusket()
//        calculateTotalAmount()
//
//
////        updateTasksList()
//
//    }
    
    func calculateTotalAmount() {
        var totalAmount = 0.0
        for i in 0..<productsInBusket.count {
            totalAmount += round(Double(productsInBusket[i].price) ?? 0)
            self.totalAmountLabel.text = "\(totalAmount)"
        }
    }
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsInBusket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = basketTableView.dequeueReusableCell(withIdentifier: "BasketCell") as! BasketTableViewCell
        
        let url = URL(string: "http://blackstarshop.ru/\(productsInBusket[indexPath.row].mainImage)")
        let data = try? Data(contentsOf: url!)
        cell.imageView?.image = UIImage(data: data!)
        
        cell.colorLabel.attributedText = NSMutableAttributedString(string: "\(productsInBusket[indexPath.row].colorName)", attributes: [NSAttributedString.Key.kern: 0.13])
        
        cell.titleLabel.attributedText = NSMutableAttributedString(string: "\(productsInBusket[indexPath.row].name)", attributes: [NSAttributedString.Key.kern: 0.19])
        
        if !productsInBusket[indexPath.row].offers.isEmpty {
            cell.sizeLabel.attributedText = NSMutableAttributedString(string: "\(productsInBusket[indexPath.row].offers[0].size)", attributes: [NSAttributedString.Key.kern: 0.13])
        }
        
        cell.priceLabel.attributedText = NSMutableAttributedString(string: "\(round(Double(productsInBusket[indexPath.row].price) ?? 0))", attributes: [NSAttributedString.Key.kern: 0.18])
        
        cell.buttonPressed = {
            let customAlertInstantiator = CustomAlertInstantiator()
            
            let yesButton = AlertButton(title: "ДА", action: {
                RealmDataBase.shared.deleteProduct(id: self.productsInBusket[indexPath.row].offers[0].productOfferID)
                self.updateProductsInBusket()
                self.calculateTotalAmount()
                self.basketTableView.reloadData()
            }, titleColor: UIColor.white, backgroundColor: #colorLiteral(red: 0, green: 0.4780656695, blue: 0.9984853864, alpha: 1), cornerRadius: 8)
            
            let noButton = AlertButton(title: " НЕТ", action: {
                
            }, titleColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cornerRadius: 8, borderWidth: 1, borderColor: #colorLiteral(red: 0.5921055079, green: 0.5921911001, blue: 0.5920783877, alpha: 1))
            
            let alert = AlertPayload(message: "Удалить товар из корзины?", messageColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), buttons: [yesButton, noButton])

            customAlertInstantiator.showAlert(payload: alert, parentViewController: self)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        basketTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeProduct(productOfferID: productsInBusket[indexPath.row].offers[0].productOfferID)
            updateProductsInBusket()
            calculateTotalAmount()
            basketTableView.reloadData()
        }
    }
    
}
