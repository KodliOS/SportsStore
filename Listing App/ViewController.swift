//
//  ViewController.swift
//  Listing App
//
//  Created by Oguz on 9.01.2020.
//  Copyright © 2020 Oguz. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private var products = [
        ("Kayak", "A boat for one person", "Watersports", 275.0, 10), ("Lifejacket", "Protective and fashionable", "Watersports", 48.95, 14), ("Soccer Ball", "FIFA-approved size and weight", "Soccer", 19.5, 32), ("Corner Flags", "Give your playing field a professional touch","Soccer", 34.95, 1),("Stadium", "Flat-packed 35,000-seat stadium", "Soccer", 79500.0, 4), ("Thinking Cap", "Improve your brain efficiency by 75%", "Chess", 16.0, 8), ("Unsteady Chair", "Secretly give your opponent a disadvantage","Chess", 29.95, 3),("Human Chess Board", "A fun game for the family", "Chess", 75.0, 2), ("Bling-Bling King", "Gold-plated, diamond-studded King","Chess", 1200.0, 4)]
    
    private lazy var totalStockLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .white
        label.text = "Label"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.frame = CGRect(x: 0, y: view.frame.height*0.9 , width: view.frame.width, height: view.frame.height*0.1)
        return label
    }()
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductTableCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 0, y: view.frame.height*0.0334, width: view.frame.width, height: view.frame.height*0.9)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(totalStockLabel)
        view.addSubview(mainTableView)
        displayStockTotal()
    }
    
    func displayStockTotal() {
        let stockTotal = products.reduce(0,
                                         {(total, product) -> Int in return total + product.4}); totalStockLabel.text = "\(stockTotal) Products in Stock";
    }
    
    func stockLevelDidChange(_ sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let id = cell.productId {
                        var newStockLevel:Int?
                        if let stepper = sender as? UIStepper { newStockLevel = Int(stepper.value)
                        } else if let textfield = sender as? UITextField { if let newValue = Int(textfield.text ?? "0") {
                            newStockLevel = newValue
                            }
                        }
                        if let level = newStockLevel {
                            products[id].4 = level
                            cell.setStepper(Double(level))
                            cell.setField(String(level))
                        }
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }
}
//MARK: - UITableViewDelegate Methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableCell
        let product = products[indexPath.row]
        cell.configure(product, index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/11
    }
}

//MARK: - ProductTableCell Methods

extension ViewController: ProductTableCellDelegate {
    func productTableCell(_ cell: ProductTableCell, didTapStepper stepper: UIStepper) {
        stockLevelDidChange(stepper)
    }
}
