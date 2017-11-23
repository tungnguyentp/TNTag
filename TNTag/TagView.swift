//
//  TagView.swift
//  TNTag
//
//  Created by Tung Nguyen on 11/22/17.
//  Copyright © 2017 Tung Nguyen. All rights reserved.
//

import UIKit

protocol TagViewDelegate {
    func didSelectTag(row:Int ,value:String)
}

class TagView: UIView {
    
    // MARK: Var
    var dataSource:[String] = []
    var delegateTagView: TagViewDelegate?
    var buttonArray:[UIButton] = []
    var button = UIButton()
    
    // MARK: Config Buton
    var bgButton:UIColor = UIColor.purple
    var bgButtonSelect:UIColor = UIColor.black
    var fontButton:UIFont = UIFont.systemFont(ofSize: 15)
    var textColorButton:UIColor = UIColor.white
    var textColorButtonSelect:UIColor = UIColor.green
    var heightButton:CGFloat = 30
    var cornerRadiusButton:CGFloat = 5
    var borderColorButton:CGColor = UIColor.darkGray.cgColor
    var borderWidthButton:CGFloat = 1
    
    // MARK: Config Value
    var origiX: CGFloat = 0
    var origiY: CGFloat = 0
    var padingL:CGFloat = 5
    var padingR:CGFloat = 5
    var spaceX:CGFloat = 5
    var spaceY:CGFloat = 5
    var row:Int = 0
    var indexDefault:Int = 0
    
    // MARK: Config IBInspectable TagView
    @IBInspectable var bgColor: UIColor = UIColor.white {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    @IBInspectable var borderColor: CGColor = UIColor.darkGray.cgColor {
        didSet {
            layer.borderColor = borderColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: Func
    override func layoutSubviews() {
        
        setupTagView()
        calculatorSpaceButton()
    }
    func setupTagView(){
        self.layer.masksToBounds = false
        self.backgroundColor = bgColor
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
    
    func setupButton(){
        button.titleLabel?.font = fontButton
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.backgroundColor = bgButton
        button.layer.cornerRadius = cornerRadiusButton
        button.layer.borderColor = borderColorButton
        button.layer.borderWidth = borderWidthButton
        button.setTitleColor(textColorButton, for: .normal)
        button.layer.masksToBounds = false
    }
    
    func calculatorSpaceButton(){
        for (index, data) in dataSource.enumerated() {
            
            let widthString = data.width(withConstraintedHeight: 0, font: fontButton)
            
            button = UIButton(frame: CGRect(x: origiX + spaceX, y: origiY + spaceY, width: widthString + padingL + padingR, height: heightButton))
            origiX = button.frame.origin.x + widthString + padingL + padingR
            
            if (origiX >= self.frame.width){
                row = row + 1
                origiX = 0
                origiY = heightButton * CGFloat(row) + spaceY * CGFloat(row)
                
                button = UIButton(frame: CGRect(x: origiX + spaceX, y: origiY + spaceY, width: widthString + padingL + padingR, height: heightButton))
                origiX = button.frame.origin.x + widthString + padingL + padingR
            }
            
            setupButton()
            button.tag = index
            button.setTitle(data, for: .normal)
            buttonArray.append(button)
            self.addSubview(button)
            
        }
        buttonArray[indexDefault].backgroundColor = bgButtonSelect
        buttonArray[indexDefault].setTitleColor(textColorButtonSelect, for: .normal)
    }
    
    @objc func tapButton(but: UIButton){
       
        for button in buttonArray{
            button.backgroundColor = bgButton
            button.setTitleColor(textColorButton, for: .normal)
        }
        buttonArray[but.tag].backgroundColor = bgButtonSelect
        buttonArray[but.tag].setTitleColor(textColorButtonSelect, for: .normal)
        
        self.delegateTagView?.didSelectTag(row: but.tag, value: (buttonArray[but.tag].titleLabel?.text)!)
    }
}

// MARK: Extention

extension String {
    func width(withConstraintedHeight height: CGFloat, font: UIFont?) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font!], context: nil)
        
        return ceil(boundingBox.width)
    }
}
