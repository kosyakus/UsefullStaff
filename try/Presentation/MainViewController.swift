//
//  MainViewController.swift
//  try
//
//  Created by Natali on 16.10.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
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
            
            let firstVar = NSAttributedString(string: "\(myVar)", attributes: baseAttributes)
            let secondVar = NSAttributedString(string: errorDescription, attributes: baseAttributes)
            
//            let firstVar = NSAttributedString(string: "\(myVar)")
//            let secondVar = NSAttributedString(string: errorDescription)
            
            //let attributedText = self.view.firstAndSecondAttributedText(firstText: "\(myVar)", secondText: errorDescription, firstTextColor: .blue, firstTextSize: 14.0, firstTextWeight: .bold, secondTextColor: .purple, secondTextSize: 17.0, secondTextWeight: .light, withSpace: true)
            
            htmlLabel.attributedText = NSAttributedString(format: attributedString, args: firstVar, secondVar)
            //htmlLabel.text = String(format: "У вас %@ общих знакомых из %@ стран, узнайте подробности!", errorDescription, errorDescription)

        } catch _ {
            print("Cannot create attributed String")
        }
        
    }

}
