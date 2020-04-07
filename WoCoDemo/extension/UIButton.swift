//
//  UIButton.swift
//  WoCoDemo
//
//  Created by Mujahid on 27/02/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import Foundation
import UIKit
public extension UIButton {
    func setIconLableLeft(string: String, image: String) {
        
        
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: image)

    
        
        attachment.bounds = CGRect(x: 2, y: -4, width: attachment.image!.size.width , height: attachment.image!.size.height)
        
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        let attributedText: NSMutableAttributedString = NSMutableAttributedString()
    
        
        
        
       
        attributedText.append(attachmentString)
        attributedText.append(NSAttributedString(string:  "\(string)  "))
        self.setAttributedTitle(attributedText, for: .normal)
        
    }

}
