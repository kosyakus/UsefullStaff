//
//  ViewController.swift
//  try
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var htmlLabel: UILabel!
    let myVar = 404
    let errorDescription = "page not found"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let htmlString = "<![CDATA[<b>Код ошибки:</b> %@ <br> <b>Описание ошибки:</b> %@ %@ %@)"
        
        //let data = Data(htmlString.utf8)
        guard let data = htmlString.data(using: String.Encoding.utf8) else { return }
        do {
            let attributedString = try NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                                          documentAttributes: nil)
            
            // some default attribute to use for text
            let baseAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Georgia-Italic", size: 14) ?? .systemFont(ofSize: 14), .foregroundColor: UIColor.orange]
            
//            let firstVar = NSAttributedString(string: "\(myVar)", attributes: baseAttributes)
//            let secondVar = NSAttributedString(string: errorDescription, attributes: baseAttributes)
            
            let firstVar = NSAttributedString(string: "\(myVar)")
            let secondVar = NSAttributedString(string: errorDescription)
            
            let attributedText = self.view.firstAndSecondAttributedText(firstText: "\(myVar)", secondText: errorDescription, firstTextColor: .blue, firstTextSize: 14.0, firstTextWeight: .bold, secondTextColor: .purple, secondTextSize: 17.0, secondTextWeight: .light, withSpace: true)
            
            htmlLabel.attributedText = NSAttributedString(format: attributedString, args: firstVar, secondVar)

        } catch _ {
            print("Cannot create attributed String")
        }
        
    }

}


public extension NSAttributedString {
    convenience init(format: NSAttributedString, args: NSAttributedString...) {
        let mutableNSAttributedString = NSMutableAttributedString(attributedString: format)

        var nsRange = NSString(string: mutableNSAttributedString.string).range(of: "%@")
        var param = 0
        var arguments = args
        
        while nsRange.location != NSNotFound {
            
//            guard args.count > 0, param < args.count else {
//                fatalError("Not enough arguments provided for \(format)")
//            }
            
            if arguments.count > 0, param < arguments.count {
                arguments.append(NSAttributedString(string:""))
            }

            mutableNSAttributedString.replaceCharacters(in: nsRange, with: arguments[param])
            param += 1
            nsRange = NSString(string: mutableNSAttributedString.string).range(of: "%@")
        }

        self.init(attributedString: mutableNSAttributedString)
    }
}

extension UIView {
    
    // Set Attributet text for any label
    func firstAndSecondAttributedText(
        firstText firstTextValue: String,
        secondText secondTextValue: String,
        firstTextColor firstTextColorValue: UIColor,
        firstTextSize firstTextSizeValue: CGFloat,
        firstTextWeight firstTextWeightValue: UIFont.Weight,
        secondTextColor secondTextColorValue: UIColor,
        secondTextSize secondTextSizeValue: CGFloat,
        secondTextWeight secondTextWeightValue: UIFont.Weight,
        withSpace withSpaceValue: Bool) -> NSAttributedString
    {
        let nameWithSpace = firstTextValue + (withSpaceValue ? " " : "")
        let allInOneTitle = nameWithSpace + secondTextValue
        let attributedTitle = NSMutableAttributedString(string: allInOneTitle, attributes: [.font: UIFont.systemFont(ofSize: firstTextSizeValue, weight: firstTextWeightValue), .foregroundColor: firstTextColorValue])
        attributedTitle.addAttribute(.foregroundColor, value: secondTextColorValue, range: (attributedTitle.string as NSString).range(of: secondTextValue))
        attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: secondTextSizeValue, weight: secondTextWeightValue), range: (attributedTitle.string as NSString).range(of: secondTextValue))
        return attributedTitle
    }

    // Set Attributet text for any label
    func attributedTextFromStringWithOtherContainedString(
        firstText firstTextValue: String,
        secondText secondTextValue: String,
        firstTextColor firstTextColorValue: UIColor,
        firstTextSize firstTextSizeValue: CGFloat,
        firstTextWeight firstTextWeightValue: UIFont.Weight,
        secondTextColor secondTextColorValue: UIColor,
        secondTextSize secondTextSizeValue: CGFloat,
        secondTextWeight secondTextWeightValue: UIFont.Weight
        ) -> NSAttributedString
    {
        let allInOneTitle = firstTextValue
        let attributedTitle = NSMutableAttributedString(string: allInOneTitle, attributes: [.font: UIFont.systemFont(ofSize: firstTextSizeValue, weight: firstTextWeightValue), .foregroundColor: firstTextColorValue])
        attributedTitle.addAttribute(.foregroundColor, value: secondTextColorValue, range: (attributedTitle.string as NSString).range(of: secondTextValue))
        attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: secondTextSizeValue, weight: secondTextWeightValue), range: (attributedTitle.string as NSString).range(of: secondTextValue))
        return attributedTitle
    }
    
}
