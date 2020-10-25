//
//  CustomTextField.swift
//  Parcel
//
//  Created by Agha Shahriyar on 18/08/2020.
//  Copyright © 2020 Parcel24. All rights reserved.
//


import UIKit

import Foundation
import UIKit

public protocol RightViewDelegate:class {
    func rightViewAction(rightView : UIView)
}

public protocol LeftViewDelegate:class {
    func leftViewAction(leftView : UIView)
}

@IBDesignable public class TextFieldAnimation: UITextField {
    
     weak public var rightViewDelegate: RightViewDelegate?
     weak public var leftViewDelegate: LeftViewDelegate?
    fileprivate var activePlaceHolder  = UILabel()
    fileprivate let animationDuration = 0.1
    fileprivate var awesomeFontLabel = UILabel()
    
    @IBInspectable public var placeholderColor: UIColor = .lightGray {
        didSet {
            let placeholderStr = placeholder ?? ""
            attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
    
    @IBInspectable public var placeHolderSize: UIFont? {
        didSet {
            self.attributedPlaceholder = NSMutableAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.font:UIFont(name: "", size: 0)!])
        }
    }
    
    @IBInspectable public var focusTintColor: UIColor = .black {
        didSet {
            if self.rightView != nil {
                self.rightView?.tintColor = self.focusTintColor
            }
            if self.leftView != nil {
                self.leftView?.tintColor = self.focusTintColor
            }
        }
    }
    
    @IBInspectable public var unFocusTintColor: UIColor = .lightGray
    {
        didSet {
            if self.rightView != nil {
                self.rightView?.tintColor = self.unFocusTintColor
            }
            if self.leftView != nil {
                self.leftView?.tintColor = self.unFocusTintColor
            }
        }
    }
    
    @IBInspectable public var activePlaceHolderTexColor: UIColor = .black {
        didSet {
            activePlaceHolder.textColor = activePlaceHolderTexColor
        }
    }
    
    @IBInspectable public var activePlaceHolderBackgroundColor: UIColor = .white {
        didSet {
            self.activePlaceHolder.backgroundColor = activePlaceHolderBackgroundColor
        }
    }
    
    @IBInspectable public var activePlaceHolderFont: UIFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            activePlaceHolder.font = activePlaceHolderFont
            activePlaceHolder.sizeToFit()
        }
    }
    
    @IBInspectable public var xAxisActivePlaceHolder: CGFloat = 0
    
    @IBInspectable public var activePlaceHolderYPadding : CGFloat = 0.0 {
        didSet {
            var frame = activePlaceHolder.frame
            frame.origin.y = activePlaceHolderYPadding
            activePlaceHolder.frame = frame
        }
    }
    
    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
    @IBInspectable public var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    
    @IBInspectable public var rightImage: UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable public var rightTextAwesome: String?{
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable public var rightPadding: CGFloat = 0
    
    @IBInspectable public var color: UIColor = UIColor.lightGray {
        didSet {
            updateRightView()
        }
    }
    
    func updateRightView() {
        if let image = rightImage {
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            let rightTap = UITapGestureRecognizer(target: self, action: #selector(self.rightViewTap(_:)))
            imageView.addGestureRecognizer(rightTap)
            imageView.isUserInteractionEnabled = true
            rightView = imageView
        } else if let text = rightTextAwesome {
            rightViewMode = .always
            awesomeFontLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
            awesomeFontLabel.font = UIFont.init(name: "FontAwesome5Free-Solid", size: 20)
            awesomeFontLabel.text = text
            awesomeFontLabel.textColor = color
            awesomeFontLabel.textAlignment = .center
            let tap = UITapGestureRecognizer(target: self, action: #selector(rightViewTap(_:)))
            awesomeFontLabel.isUserInteractionEnabled = true
            awesomeFontLabel.addGestureRecognizer(tap)
            rightView = awesomeFontLabel
        }else {
            rightViewMode = .never
            rightView = nil
        }
    }
    
    func updateRoghtFontAwesome() {
        if  let text = rightTextAwesome {
            rightViewMode = .always
            let rightLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
            rightLabel.font = UIFont.init(name: "FontAwesome5Free-Solid", size: 20)
            rightLabel.text = text
            rightLabel.textColor = .black
            rightLabel.backgroundColor = .white
            
            rightView = rightLabel
        } else {
            rightViewMode = .never
            rightView = nil
        }
    }
    
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            
            let leftTap = UITapGestureRecognizer(target: self, action: #selector(self.leftViewTap(_:)))
            imageView.addGestureRecognizer(leftTap)
            imageView.isUserInteractionEnabled = true
            leftView = imageView
        } else {
            if leftPadding > 0 {
                leftViewMode = .always
                let view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
                // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
                view.backgroundColor = .clear
                leftView = view
                
            } else {
                leftViewMode = .never
                //   rightView = nil
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    func setup() {
        activePlaceHolder.font = self.font
        activePlaceHolder.textColor = activePlaceHolderTexColor
        activePlaceHolder.backgroundColor = activePlaceHolderBackgroundColor
        if let placeHolderSt = self.placeholder, !placeHolderSt.isEmpty {
            self.activePlaceHolder.text = placeHolderSt
            self.activePlaceHolder.sizeToFit()
        }
        self.addSubview(activePlaceHolder)
    }
    
    @objc func rightViewTap(_ tapView: UITapGestureRecognizer) {
        if let tap = tapView.view, !(self.text?.isEmpty ?? true) {
            self.rightViewDelegate?.rightViewAction(rightView: tap)
        }
//        if let getImage = tapView.view as? UIImageView
//        {
//            self.rightViewDelegate?.rightViewAction(rightImageView: getImage)
//        }
    }
    
    @objc func leftViewTap(_ tapView: UITapGestureRecognizer) {
        if let tap = tapView.view, !(self.text?.isEmpty ?? true) {
            self.leftViewDelegate?.leftViewAction(leftView: tap)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let isFirstRes = isFirstResponder
        if let txt = text , !txt.isEmpty && isFirstRes {
            activePlaceHolder.textColor = activePlaceHolderTexColor
        } else {
            activePlaceHolder.textColor = activePlaceHolderTexColor
        }
        if let enterText = text , enterText.isEmpty {
            hidePlaceHolder(isFirstRes)
        } else {
            showPlaceHolder(isFirstRes)
        }
    }
    
    open override func textRect(forBounds bounds:CGRect) -> CGRect {
        var bound = super.textRect(forBounds: bounds)
        if let enterText = text , !enterText.isEmpty {
            var top = ceil(activePlaceHolder.font.lineHeight) //+ hintYPadding)
            top = min(top, maxTopInset())
            bound = bound.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return bound.integral
    }
    
    open override func editingRect(forBounds bounds:CGRect) -> CGRect {
        var bounds = super.editingRect(forBounds: bounds)
        if let txt = text , !txt.isEmpty {
            var top = ceil(activePlaceHolder.font.lineHeight) //+ hintYPadding)
            top = min(top, maxTopInset())
            bounds = bounds.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return bounds.integral
    }
    
    fileprivate func showPlaceHolder(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay: 0, options: [.beginFromCurrentState,.curveEaseOut]) {
            self.activePlaceHolder.alpha = 1.0
            var frame = self.activePlaceHolder.frame
            frame.origin.y = self.activePlaceHolderYPadding
            frame.origin.x = self.xAxisActivePlaceHolder
            self.activePlaceHolder.frame = frame
            
            if self.rightView != nil {
                self.rightView?.tintColor = self.focusTintColor
                self.awesomeFontLabel.textColor = self.focusTintColor
                
            }
            if self.leftView != nil {
                self.leftView?.tintColor = self.focusTintColor
            }
        } completion: { (true) in
            
        }
    }
    
    fileprivate func hidePlaceHolder(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        
        UIView.animate(withDuration: dur, delay: 0, options: [.beginFromCurrentState,.curveEaseOut], animations: {
            self.activePlaceHolder.alpha = 0.0
            var frame = self.activePlaceHolder.frame
            frame.origin.y = self.activePlaceHolder.font.lineHeight //+ self.hintYPadding
            self.activePlaceHolder.frame = frame
            
            if self.rightView != nil {
                self.rightView?.tintColor = self.unFocusTintColor
                self.awesomeFontLabel.textColor = self.unFocusTintColor
            }
            if self.leftView != nil {
                self.leftView?.tintColor = self.unFocusTintColor
            }
        }, completion: nil)
    }
    
    fileprivate func maxTopInset()->CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
        }
        return 0
    }
}
