//
//  String.swift
//  WoCoDemo
//
//  Created by Mujahid on 27/02/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import Foundation
import UIKit
extension String{
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    static func isNilOrEmptyWithText(string: String?) -> String {
        
        if (string == nil || string!.isEmpty || string!.count == 0)
        {
            return ""
            
        }else{
            return string!
        }
        
    }

}
