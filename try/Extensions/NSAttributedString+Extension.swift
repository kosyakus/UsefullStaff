//
//  NSAttributedString+Extension.swift
//  try
//
//  Created by Natali on 15.10.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

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
