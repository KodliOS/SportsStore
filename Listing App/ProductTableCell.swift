//
//  ProductTableCell.swift
//  Listing App
//
//  Created by Oguz on 9.01.2020.
//  Copyright © 2020 Oguz. All rights reserved.
//

import UIKit

protocol ProductTableCellDelegate: class {
    func productTableCell(_ cell: ProductTableCell, didTapStepper stepper: UIStepper)
}

class ProductTableCell: UITableViewCell {
    
    var productId:Int?
    
    weak var delegate: ProductTableCellDelegate?
    
    private lazy var nameLabel: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.allowsEditingTextAttributes = true
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        textField.frame = CGRect(x: 12, y: 10, width: self.frame.width, height: self.frame.height/1.8)
        return textField
    }()
    
    private lazy var descriptionLabel: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.allowsEditingTextAttributes = true
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.frame = CGRect(x: 12, y: 50, width: self.frame.width, height: self.frame.height/2)
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }()
    
    private lazy var stockField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.allowsEditingTextAttributes = true
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textField.frame = CGRect(x: (self.frame.width * 1.13), y: 10, width: self.frame.width/9, height: self.frame.height/2)
        return textField
    }()
    
    private lazy var stockStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.stepValue = 1
        stepper.frame = CGRect(x: (self.frame.width * 0.82), y: 10, width: self.frame.width/10, height: self.frame.height/2.5)
        return stepper
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(stockField)
        self.addSubview(stockStepper)
        stockStepper.addTarget(self, action: #selector(stepperTapped(_:)), for: .allTouchEvents)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func stepperTapped(_ sender: UIStepper) {
        delegate?.productTableCell(self, didTapStepper: sender)
    }
    
   public func setStepper(_ value: Double) {
        stockStepper.value = value
    }
    
   public func setField(_ text: String) {
        stockField.text = text
    }
    
    public func configure(_ product: (String, String, String, Double, Int), index: Int) {
        productId = index
        nameLabel.text = product.0
        descriptionLabel.text = product.1
        stockStepper.value = Double(product.4)
        stockField.text = String(product.4)
    }
}
