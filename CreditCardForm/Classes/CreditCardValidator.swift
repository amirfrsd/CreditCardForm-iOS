//
//  CreditCardValidator.swift
//
//  Created by Vitaliy Kuzmenko on 02/06/15.
//  Copyright (c) 2015. All rights reserved.
//

import Foundation

public class CreditCardValidator {
    
    public lazy var types: [CreditCardValidationType] = {
        var types = [CreditCardValidationType]()
        for object in CreditCardValidator.types {
            types.append(CreditCardValidationType(dict: object))
        }
        return types
        }()
    
    public init() { }
    
    /**
    Get card type from string
    
    - parameter string: card number string
    
    - returns: CreditCardValidationType structure
    */
    public func type(from string: String) -> CreditCardValidationType? {
        for type in types {
            let predicate = NSPredicate(format: "SELF MATCHES %@", type.regex)
            let numbersString = self.onlyNumbers(string: string)
            if predicate.evaluate(with: numbersString) {
                return type
            }
        }
        return nil
    }
    
    /**
    Validate card number
    
    - parameter string: card number string
    
    - returns: true or false
    */
    public func validate(string: String) -> Bool {
        let length: Int? = string.count
        let subString = string.substring(location: 15, length: 1)
        let subStringOne = string.substring(location: 1, length: 10)
        let subStringTwo = string.substring(location: 10, length: 6)
        var s: Int = 0
        var k: Int = 0
        var d: Int = 0
        if (length! < 16 || Int(subStringOne!) == 0 || Int(subStringTwo!) == 0) {
            return false
        }
        for i in 0..<16 {
            let subStr = string.substring(location: i, length: 1)
            k = (i % 2 == 0) ? 2 : 1
            d = Int(subStr!)! * k
            s += (d > 9) ? d - 9 : d
        }
        return (s % 10) == 0
    }
    
    /**
    Validate card number string for type
    
    - parameter string: card number string
    - parameter type:   CreditCardValidationType structure
    
    - returns: true or false
    */
    public func validate(string: String, forType type: CreditCardValidationType) -> Bool {
        return self.type(from: string) == type
    }
    
    public func onlyNumbers(string: String) -> String {
        let set = CharacterSet.decimalDigits.inverted
        let numbers = string.components(separatedBy: set)
        return numbers.joined(separator: "")
    }
    
    // MARK: - Loading data
    
    private static let types = [
        [
            "name": "بانک سامان",
            "regex": "^621986.{10}"
        ], [
            "name": "موسسه اعتباري توسعه",
            "regex": "^628157.{10}"
        ], [
            "name": "موسسه اعتباري ملل",
            "regex": "^606256.{10}"
        ], [
            "name": "موسسه اعتباري کوثر",
            "regex": "^505801.{10}"
        ], [
            "name": "بانک اقتصادنوين",
            "regex": "^627412.{10}"
        ], [
            "name": "بانک انصار",
            "regex": "^627381.{10}"
        ], [
            "name": "بانک ايران زمين",
            "regex": "^505785.{10}"
        ], [
            "name": "بانک آينده",
            "regex": "^636214.{10}"
        ], [
            "name": "پست بانک",
            "regex": "^627760.{10}"
        ], [
            "name": "بانک توسعه تعاون",
            "regex": "^502908.{10}"
        ], [
            "name": "بانک حكمت ايرانيان",
            "regex": "^636949.{10}"
        ], [
            "name": "بانک دي",
            "regex": "^502938.{10}"
        ], [
            "name": "بانک رسالت",
            "regex": "^504172.{10}"
        ], [
            "name": "بانک رفاه",
            "regex": "^589463.{10}"
        ], [
            "name": "بانک سپه",
            "regex": "^589210.{10}"
        ], [
            "name": "بانک سرمایه",
            "regex": "^639607.{10}"
        ], [
            "name": "بانک سینا",
            "regex": "^639346.{10}"
        ], [
            "name": "بانک صادرات",
            "regex": "^603769.{10}"
        ], [
            "name": "بانک صنعت و معدن",
            "regex": "^627961.{10}"
        ], [
            "name": "بانک قوامین",
            "regex": "^639599.{10}"
        ], [
            "name": "بانک کار آفرین",
            "regex": "^627488.{10}"
        ], [
            "name": "بانک گردشگری",
            "regex": "^505416.{10}"
        ], [
            "name": "بانک مسکن",
            "regex": "^628023.{10}"
        ], [
            "name": "بانک ملت",
            "regex": "^610433.{10}"
        ], [
            "name": "بانک ملی",
            "regex": "^603799.{10}"
        ], [
            "name": "بانک مهر ایران",
            "regex": "^606373.{10}"
        ], [
            "name": "بانک مهر اقتصاد",
            "regex": "^639370.{10}"
        ], [
            "name": "موسسه اعتباری نور",
            "regex": "^507677.{10}"
        ], [
            "name": "بانک پارسيان",
            "regex": "^(?:622106|639194).{10}"
        ], [
            "name": "بانک پاسارگاد",
            "regex": "^(?:502229|639347).{10}"
        ], [
            "name": "بانک تجارت",
            "regex": "^(?:585983|627353).{10}"
        ], [
            "name": "بانک توسعه صادرات",
            "regex": "^(?:627648|207177).{10}"
        ], [
            "name": "بانک خاورمیانه",
            "regex": "^(?:505809|585947).{10}"
        ], [
            "name": "بانک شهر",
            "regex": "^(?:504706|502806).{10}"
        ], [
            "name": "بانک کشاورزی",
            "regex": "^(?:639217|603770).{10}"
        ],
    ]
    
}
