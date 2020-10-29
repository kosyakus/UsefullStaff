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
        
        htmlLabel.textColor = UIColor.green
        htmlLabel.font = htmlLabel.font.withSize(20)
        
        // Do any additional setup after loading the view.
        //let htmlString = "<![CDATA[<b>Код ошибки:</b> %@ <br> <b>Описание ошибки:</b> %@ %@ %@)"
        let htmlString = "<font color=\"#FF5669\">Внимание!</font> Ваше предыдущее приглашение проигнорировано. <b>При очередной</b> отправке приглашения, <font color=\"#FF5669\">NumСy уже НЕ вернутся на ваш счет</font>. Это делается для защиты от слишком частых и спам-запросов."
        
        //let data = Data(htmlString.utf8)
        guard let data = htmlString.data(using: String.Encoding.utf8) else { return }
        do {
            // some default attribute to use for text
            let baseAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Georgia-Italic", size: 20) ?? .systemFont(ofSize: 14), .foregroundColor: UIColor.green]
            
            let attributedString = try NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                                          documentAttributes: nil)
            
            let textRangeForFont : NSRange = NSMakeRange(0, attributedString.length)
            //attributedString.addAttributes([NSFontAttributeName : UIFont(name: "Arial", size: 20)!], range: textRangeForFont)
            
            
            
            let firstVar = NSAttributedString(string: "\(myVar)", attributes: baseAttributes)
            let secondVar = NSAttributedString(string: errorDescription, attributes: baseAttributes)
            
//            let firstVar = NSAttributedString(string: "\(myVar)")
//            let secondVar = NSAttributedString(string: errorDescription)
            
            //let attributedText = self.view.firstAndSecondAttributedText(firstText: "\(myVar)", secondText: errorDescription, firstTextColor: .blue, firstTextSize: 14.0, firstTextWeight: .bold, secondTextColor: .purple, secondTextSize: 17.0, secondTextWeight: .light, withSpace: true)
            
            //htmlLabel.attributedText =  attributedString //NSAttributedString(format: attributedString, args: firstVar, secondVar)
            //htmlLabel.text = String(format: "У вас %@ общих знакомых из %@ стран, узнайте подробности!", errorDescription, errorDescription)
            
            
            
            
            htmlLabel.attributedText = htmlString.htmlAttributedString(size: 20, color: .lightGray)
            
            
            

        } catch _ {
            print("Cannot create attributed String")
        }
        
    }
}

extension String {
    func htmlAttributedString(size: CGFloat, color: UIColor) -> NSAttributedString? {
        let htmlTemplate = """
        <!doctype html>
        <html>
          <head>
            <style>
              body {
                color: \(color.toHexString());
                font-family: Georgia, serif;
                font-size: \(size)px;
              }
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

        guard let data = htmlTemplate.data(using: String.Encoding.utf8) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil
            ) else {
            return nil
        }

        return attributedString
    }
}

extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return NSString(format:"#%06x", rgb) as String
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

}
