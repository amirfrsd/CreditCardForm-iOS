//
//  CreditCardForumView.swift
//  CreditCardForm
//
//  Created by Atakishiyev Orazdurdy on 11/28/16.
//  Copyright © 2016 Veriloft. All rights reserved.
//

import UIKit

public enum Brands : String {
    case NONE, Saman, Tosee, Melal, Kosar, EghtesadNovin, Ansar, Iranzamin, Ayandeh, Parsian, Pasargad, PostBank, Tejarat, ToseTaavon, ToseSaderat, HekmatIranian, Khavarmiane, Dey, Resalat, Refah, Sepah, Sarmayeh, Sina, Shahr, Saderat, SanatMadan, Ghavamin, KarAfarin, Keshavarzi, Gardeshgari, Maskan, Mellat, Melli, MehrIran, MehrEghtesad, Noor
}

@IBDesignable
public class CreditCardFormView : UIView {
    
    fileprivate var cardView: UIView    = UIView(frame: .zero)
    fileprivate var backView: UIView    = UIView(frame: .zero)
    fileprivate var frontView: UIView   = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
    fileprivate var gradientLayer       = CAGradientLayer()
    fileprivate var showingBack:Bool    = false
    
    fileprivate var backImage: UIImageView   = UIImageView(frame: .zero)
    fileprivate var brandImageView           = UIImageView(frame: .zero)
    fileprivate var cardNumber:AKMaskField   = AKMaskField(frame: .zero)
    fileprivate var cardHolderText:UILabel   = UILabel(frame: .zero)
    fileprivate var cardHolder:UILabel       = UILabel(frame: .zero)
    fileprivate var expireDate: AKMaskField  = AKMaskField(frame: .zero)
    fileprivate var expireDateText: UILabel  = UILabel(frame: .zero)
    fileprivate var backLine: UIView         = UIView(frame: .zero)
    fileprivate var cvc: AKMaskField         = AKMaskField(frame: .zero)
    fileprivate var chipImg: UIImageView     = UIImageView(frame: .zero)
    fileprivate var amex                    = false
    
    public var colors = [String : [UIColor]]()
    
    @IBInspectable
    public var defaultCardColor: UIColor = UIColor.hexStr(hexStr: "363434", alpha: 1) {
        didSet {
            gradientLayer.colors = [defaultCardColor.cgColor, defaultCardColor.cgColor]
            backView.backgroundColor = defaultCardColor
        }
    }
    
    @IBInspectable
    public var cardHolderExpireDateTextColor: UIColor = UIColor.hexStr(hexStr: "#bdc3c7", alpha: 1) {
        didSet {
            cardHolderText.textColor = cardHolderExpireDateTextColor
            expireDateText.textColor = cardHolderExpireDateTextColor
        }
    }
    
    @IBInspectable
    public var cardHolderExpireDateColor: UIColor = .white {
        didSet {
            cardHolder.textColor = cardHolderExpireDateColor
            expireDate.textColor = cardHolderExpireDateColor
            cardNumber.textColor = cardHolderExpireDateColor
        }
    }
    
    @IBInspectable
    public var backLineColor: UIColor = .black {
        didSet {
            backLine.backgroundColor = backLineColor
        }
    }
    
    @IBInspectable
    public var chipImage = UIImage(named: "chip", in: Bundle.currentBundle(), compatibleWith: nil) {
        didSet {
            chipImg.image = chipImage
        }
    }
    
    @IBInspectable
    public var cardHolderString = "----" {
        didSet {
            cardHolder.text = cardHolderString
        }
    }
    
    @IBInspectable
    public var cardHolderPlaceholderString = "CARD HOLDER" {
        didSet {
            cardHolderText.text = cardHolderPlaceholderString
        }
    }
    
    @IBInspectable
    public var expireDatePlaceholderText = "EXPIRY" {
        didSet {
            expireDateText.text = expireDatePlaceholderText
        }
    }
    
    @IBInspectable
    public var cardNumberMaskExpression = "{....} {....} {....} {....}" {
        didSet {
            cardNumber.maskExpression = cardNumberMaskExpression
        }
    }
    
    @IBInspectable
    public var cardNumberMaskTemplate = "**** **** **** ****" {
        didSet {
            cardNumber.maskTemplate = cardNumberMaskTemplate
        }
    }
    
    public var cardNumberFontSize: CGFloat = 20 {
        didSet {
            cardNumber.font = UIFont(name: "Helvetica Neue", size: cardNumberFontSize)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        createViews()
    }
    
    private func createViews() {
        frontView.isHidden = false
        backView.isHidden = true
        cardView.clipsToBounds = true
        
        if colors.count < 7 {
            setBrandColors()
        }
        
        createCardView()
        createFrontView()
        createbackImage()
        createBrandImageView()
        createCardNumber()
        createCardHolder()
        createCardHolderText()
        createExpireDate()
        createExpireDateText()
        createChipImage()
        createBackView()
        createBackLine()
        createCVC()
    }
    
    private func setGradientBackground(v: UIView, top: CGColor, bottom: CGColor) {
        let colorTop =  top
        let colorBottom = bottom
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = v.bounds
        backView.backgroundColor = defaultCardColor
        v.layer.addSublayer(gradientLayer)
    }
    
    private func createCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 6
        cardView.backgroundColor = .clear
        self.addSubview(cardView)
        //CardView
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.0, constant: 0.0));
    }
    
    private func createBackView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = 6
        backView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        backView.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        cardView.addSubview(backView)
        
        self.addConstraint(NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.0, constant: 0.0));
    }
    
    private func createFrontView() {
        frontView.translatesAutoresizingMaskIntoConstraints = false
        frontView.layer.cornerRadius = 6
        frontView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        frontView.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        cardView.addSubview(frontView)
        setGradientBackground(v: frontView, top: defaultCardColor.cgColor, bottom: defaultCardColor.cgColor)
        
        self.addConstraint(NSLayoutConstraint(item: frontView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: frontView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: frontView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: frontView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.0, constant: 0.0));
    }
    
    private func createbackImage() {
        backImage.translatesAutoresizingMaskIntoConstraints = false
        backImage.image = UIImage(named: "back.jpg")
        backImage.contentMode = UIView.ContentMode.scaleAspectFill
        frontView.addSubview(backImage)
        
        self.addConstraint(NSLayoutConstraint(item: backImage, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backImage, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backImage, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: backImage, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0));
    }
    
    private func createBrandImageView() {
        //Card brand image
        brandImageView.translatesAutoresizingMaskIntoConstraints = false
        brandImageView.contentMode = UIView.ContentMode.scaleAspectFit
        frontView.addSubview(brandImageView)
        
        self.addConstraint(NSLayoutConstraint(item: brandImageView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 10));
        
        self.addConstraint(NSLayoutConstraint(item: brandImageView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: -10));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==60)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": brandImageView]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==40)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": brandImageView]));
    }
    
    private func createCardNumber() {
        //Credit card number
        cardNumber.translatesAutoresizingMaskIntoConstraints = false
        cardNumber.maskExpression = cardNumberMaskExpression
        cardNumber.maskTemplate = cardNumberMaskTemplate
        cardNumber.textColor = cardHolderExpireDateColor
        cardNumber.isUserInteractionEnabled = false
        cardNumber.textAlignment = NSTextAlignment.center
        cardNumber.font = UIFont(name: "Helvetica Neue", size: cardNumberFontSize)
        frontView.addSubview(cardNumber)
        
        self.addConstraint(NSLayoutConstraint(item: cardNumber, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: cardNumber, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0.0));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==200)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": cardNumber]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==30)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": cardNumber]));
    }
    
    private func createCardHolder() {
        //Name
        cardHolder.translatesAutoresizingMaskIntoConstraints = false
        cardHolder.font = UIFont(name: "Helvetica Neue", size: 12)
        cardHolder.textColor = cardHolderExpireDateColor
        cardHolder.text = cardHolderString
        frontView.addSubview(cardHolder)
        
        self.addConstraint(NSLayoutConstraint(item: cardHolder, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -20));
        
        self.addConstraint(NSLayoutConstraint(item: cardHolder, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15));
    }
    
    private func createCardHolderText() {
        //Card holder uilabel
        cardHolderText.translatesAutoresizingMaskIntoConstraints = false
        cardHolderText.font = UIFont(name: "Helvetica Neue", size: 10)
        cardHolderText.text = cardHolderPlaceholderString
        cardHolderText.textColor = cardHolderExpireDateTextColor
        frontView.addSubview(cardHolderText)
        
        self.addConstraint(NSLayoutConstraint(item: cardHolderText, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardHolder, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: -3));
        
        self.addConstraint(NSLayoutConstraint(item: cardHolderText, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15));
    }
    
    private func createExpireDate() {
        //Expire Date
        expireDate = AKMaskField()
        expireDate.translatesAutoresizingMaskIntoConstraints = false
        expireDate.font = UIFont(name: "Helvetica Neue", size: 12)
        expireDate.maskExpression = "{..}/{..}"
        expireDate.text = "MM/YY"
        expireDate.textColor = cardHolderExpireDateColor
        frontView.addSubview(expireDate)
        
        self.addConstraint(NSLayoutConstraint(item: expireDate, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -20));
        
        self.addConstraint(NSLayoutConstraint(item: expireDate, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: -55));
    }
    
    private func createExpireDateText() {
        //Expire Date Text
        expireDateText.translatesAutoresizingMaskIntoConstraints = false
        expireDateText.font = UIFont(name: "Helvetica Neue", size: 10)
        expireDateText.text = expireDatePlaceholderText
        expireDateText.textColor = cardHolderExpireDateTextColor
        frontView.addSubview(expireDateText)
        
        self.addConstraint(NSLayoutConstraint(item: expireDateText, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: expireDate, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: -3));
        
        self.addConstraint(NSLayoutConstraint(item: expireDateText, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: -58));
    }
    
    private func createChipImage() {
        //Chip image
        chipImg.translatesAutoresizingMaskIntoConstraints = false
        chipImg.alpha = 0.5
        chipImg.image = chipImage
        frontView.addSubview(chipImg)
        
        self.addConstraint(NSLayoutConstraint(item: chipImg, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 15));
        
        self.addConstraint(NSLayoutConstraint(item: chipImg, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cardView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==45)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": chipImg]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==30)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": chipImg]));
    }
    
    private func createBackLine() {
        //BackLine
        backLine.translatesAutoresizingMaskIntoConstraints = false
        backLine.backgroundColor = backLineColor
        backView.addSubview(backLine)
        
        self.addConstraint(NSLayoutConstraint(item: backLine, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 20));
        
        self.addConstraint(NSLayoutConstraint(item: backLine, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==300)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": backLine]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==50)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": backLine]));
    }
    
    private func createCVC() {
        //CVC textfield
        cvc.translatesAutoresizingMaskIntoConstraints = false
        cvc.maskExpression = "..."
        cvc.text = "CVV2"
        cvc.backgroundColor = .white
        cvc.textAlignment = NSTextAlignment.center
        cvc.isUserInteractionEnabled = false
        backView.addSubview(cvc)
        
        self.addConstraint(NSLayoutConstraint(item: cvc, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backLine, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 10));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==50)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": cvc]));
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==25)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": cvc]));
        
        self.addConstraint(NSLayoutConstraint(item: cvc, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: -10));
    }
    
    private func setType(colors: [UIColor], alpha: CGFloat, back: UIColor) {
        UIView.animate(withDuration: 2, animations: { () -> Void in
            self.gradientLayer.colors = [colors[0].cgColor, colors[1].cgColor]
        })
        self.backView.backgroundColor = back
        self.chipImg.alpha = alpha
    }
    
    private func flip() {
        var showingSide = frontView
        var hiddenSide = backView
        if showingBack {
            (showingSide, hiddenSide) = (backView, frontView)
        }
        
        UIView.transition(from:showingSide,
                          to: hiddenSide,
                          duration: 0.7,
                          options: [UIView.AnimationOptions.transitionFlipFromRight, UIView.AnimationOptions.showHideTransitionViews],
                          completion: nil)
    }
    
    public func paymentCardTextFieldDidChange(cardNumber: String? = "", expirationYear: UInt, expirationMonth: UInt, cvc: String? = "") {
        self.cardNumber.text = cardNumber
        
        self.expireDate.text = NSString(format: "%02ld", expirationMonth) as String + "/" + (NSString(format: "%02ld", expirationYear) as String)
        
        if expirationMonth == 0 {
            expireDate.text = "MM/YY"
        }
        let v = CreditCardValidator()
        self.cvc.text = cvc
        
        guard let cardN = cardNumber else {
            return
        }
        
        if (cardN.count == 0)
        {
            self.cardNumber.maskExpression = "{....} {....} {....} {....}"
        }
        if (cardN.count >= 7 || cardN.count < 4) {
            
            guard let type = v.type(from: "\(cardN as String?)") else {
                self.brandImageView.image = nil
                if let name = colors["NONE"] {
                    setType(colors: [name[0], name[1]], alpha: 0.5, back: name[0])
                }
                return
            }

            // Visa, Mastercard, Amex etc.
            if let name = colors[type.name] {
                if(type.name.lowercased() == "amex".lowercased()){
                    if !amex {
                        self.cardNumber.maskExpression = "{....} {....} {....} {....}"
                        amex = true
                    }
                }else {
                    amex = false
                }
                self.brandImageView.image = UIImage(named: String((cardNumber?.prefix(6))!), in: Bundle.currentBundle(), compatibleWith: nil)
                setType(colors: [name[0], name[1]], alpha: 1, back: name[0])
            }else{
                setType(colors: [self.colors["DEFAULT"]![0], self.colors["DEFAULT"]![0]], alpha: 1, back: self.colors["DEFAULT"]![0])
            }
        }
    }
    
    public func paymentCardTextFieldDidEndEditingExpiration(expirationYear: UInt) {
        if "\(expirationYear)".count <= 1 {
            expireDate.text = "MM/YY"
        }
    }
    
    public func paymentCardTextFieldDidBeginEditingCVC() {
        if !showingBack {
            flip()
            showingBack = true
        }
    }
    
    public func paymentCardTextFieldDidEndEditingCVC() {
        if showingBack {
            flip()
            showingBack = false
        }
    }
    
}

//: CardColors
extension CreditCardFormView {
    
    fileprivate func setBrandColors() {
        colors[Brands.NONE.rawValue] = [defaultCardColor, defaultCardColor]
        colors["بانک سامان"] = [UIColor.hexStr(hexStr: "#2c91f7", alpha: 1), UIColor.hexStr(hexStr: "#68a2ff", alpha: 1)]
        colors["موسسه اعتباري توسعه"] = [UIColor.hexStr(hexStr: "#540000", alpha: 1), UIColor.hexStr(hexStr: "#770000", alpha: 1)]
        colors["موسسه اعتباري ملل"] = [UIColor.hexStr(hexStr: "#db8700", alpha: 1), UIColor.hexStr(hexStr: "#b77101", alpha: 1)]
        colors["موسسه اعتباري کوثر"] = [UIColor.hexStr(hexStr: "#722a7f", alpha: 1), UIColor.hexStr(hexStr: "#913da0", alpha: 1)]
        colors["بانک اقتصادنوين"] = [UIColor.hexStr(hexStr: "#380042", alpha: 1), UIColor.hexStr(hexStr: "#5f0070", alpha: 1)]
        colors["بانک انصار"] = [UIColor.hexStr(hexStr: "#686868", alpha: 1), UIColor.hexStr(hexStr: "#9b9b9b", alpha: 1)]
        colors["بانک ايران زمين"] = [UIColor.hexStr(hexStr: "#e3c4ef", alpha: 1), UIColor.hexStr(hexStr: "#efdcf7", alpha: 1)]
        colors["بانک آينده"] = [UIColor.hexStr(hexStr: "#2d1105", alpha: 1), UIColor.hexStr(hexStr: "#3f2920", alpha: 1)]
        colors["بانک پارسيان"] = [UIColor.hexStr(hexStr: "#822400", alpha: 1), UIColor.hexStr(hexStr: "#9b2b00", alpha: 1)]
        colors["بانک پاسارگاد"] = [UIColor.hexStr(hexStr: "#000000", alpha: 1), UIColor.hexStr(hexStr: "#232323", alpha: 1)]
        colors["پست بانک"] = [UIColor.hexStr(hexStr: "#267200", alpha: 1), UIColor.hexStr(hexStr: "#3c9b0c", alpha: 1)]
        colors["بانک تجارت"] = [UIColor.hexStr(hexStr: "#003770", alpha: 1), UIColor.hexStr(hexStr: "#003770", alpha: 1)]
        colors["بانک توسعه تعاون"] = [UIColor.hexStr(hexStr: "#2bce87", alpha: 1), UIColor.hexStr(hexStr: "#47d899", alpha: 1)]
        colors["بانک توسعه صادرات"] = [UIColor.hexStr(hexStr: "#62917d", alpha: 1), UIColor.hexStr(hexStr: "#7bad98", alpha: 1)]
        colors["بانک حكمت ايرانيان"] = [UIColor.hexStr(hexStr: "#486eaf", alpha: 1), UIColor.hexStr(hexStr: "#6388c6", alpha: 1)]
        colors["بانک خاورمیانه"] = [UIColor.hexStr(hexStr: "#c1800f", alpha: 1), UIColor.hexStr(hexStr: "#d39528", alpha: 1)]
        colors["بانک دي"] = [UIColor.hexStr(hexStr: "#12afb7", alpha: 1), UIColor.hexStr(hexStr: "#6bdae0", alpha: 1)]
        colors["بانک رسالت"] = [UIColor.hexStr(hexStr: "#5bbdff", alpha: 1), UIColor.hexStr(hexStr: "#84cdff", alpha: 1)]
        colors["بانک رفاه"] = [UIColor.hexStr(hexStr: "#c4c4c4", alpha: 1), UIColor.hexStr(hexStr: "#ededed", alpha: 1)]
        colors["بانک سپه"] = [UIColor.hexStr(hexStr: "#154daf", alpha: 1), UIColor.hexStr(hexStr: "#2a65cc", alpha: 1)]
        colors["بانک سرمایه"] = [UIColor.hexStr(hexStr: "#875796", alpha: 1), UIColor.hexStr(hexStr: "#ac70bf", alpha: 1)]
        colors["بانک سینا"] = [UIColor.hexStr(hexStr: "#af9b00", alpha: 1), UIColor.hexStr(hexStr: "#c1ad11", alpha: 1)]
        colors["بانک شهر"] = [UIColor.hexStr(hexStr: "#b20200", alpha: 1), UIColor.hexStr(hexStr: "#ce0a08", alpha: 1)]
        colors["بانک صادرات"] = [UIColor.hexStr(hexStr: "#5bbce5", alpha: 1), UIColor.hexStr(hexStr: "#6dcaf2", alpha: 1)]
        colors["بانک صنعت و معدن"] = [UIColor.hexStr(hexStr: "#006faf", alpha: 1), UIColor.hexStr(hexStr: "#0886ce", alpha: 1)]
        colors["بانک قوامین"] = [UIColor.hexStr(hexStr: "#e5e5e5", alpha: 1), UIColor.hexStr(hexStr: "#ffffff", alpha: 1)]
        colors["بانک کار آفرین"] = [UIColor.hexStr(hexStr: "#6cd153", alpha: 1), UIColor.hexStr(hexStr: "#80e567", alpha: 1)]
        colors["بانک کشاورزی"] = [UIColor.hexStr(hexStr: "#9bc16c", alpha: 1), UIColor.hexStr(hexStr: "#bfe590", alpha: 1)]
        colors["بانک گردشگری"] = [UIColor.hexStr(hexStr: "#7f0f0f", alpha: 1), UIColor.hexStr(hexStr: "#ad2b2b", alpha: 1)]
        colors["بانک مسکن"] = [UIColor.hexStr(hexStr: "#e85c00", alpha: 1), UIColor.hexStr(hexStr: "#ed7628", alpha: 1)]
        colors["بانک ملت"] = [UIColor.hexStr(hexStr: "#ff9ec8", alpha: 1), UIColor.hexStr(hexStr: "#ffc4dd", alpha: 1)]
        colors["بانک ملی"] = [UIColor.hexStr(hexStr: "#1775c1", alpha: 1), UIColor.hexStr(hexStr: "#3a92d8", alpha: 1)]
        colors["بانک مهر ایران"] = [UIColor.hexStr(hexStr: "#90e056", alpha: 1), UIColor.hexStr(hexStr: "#9fe070", alpha: 1)]
        colors["بانک مهر اقتصاد"] = [UIColor.hexStr(hexStr: "#9e9331", alpha: 1), UIColor.hexStr(hexStr: "#c9bd50", alpha: 1)]
        colors["موسسه اعتباری نور"] = [UIColor.hexStr(hexStr: "#7dd7d8", alpha: 1), UIColor.hexStr(hexStr: "#99e4e5", alpha: 1)]
    }
}


