//
//  BaseVC.swift
//  WoCoDemo
//
//  Created by Mujahid on 26/02/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class BaseVC: UIViewController {
var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults = UserDefaults.standard
        defaults.synchronize()
    }
    func setParam<T: Mappable>(url:String,headers:[String:Any],className:T.Type)  {
        AFWrapper.requestGETURL(url: url,headers:headers,success: { (response:T) in
            print(response)
            self.onSuccessResponse(response: response)
        }, failure: { (error:Error) in

            self.onFailResponse(response: error)
        })
        
        
    }
    
    func setParamPost<T: Mappable>(url:String,headers:[String:Any],param:[String:Any],className:T.Type)  {
        AFWrapper.requestGETURLPost(url: url,headers:headers,param:param,success: { (response:T) in
            print(response)
            self.onSuccessResponse(response: response)
        }, failure: { (error:Error) in

            self.onFailResponse(response: error)
        })
        
        
    }
    
    func onSuccessResponse(response:Any) {
         
     }
     
     func onFailResponse(response:Error) {
         
     }
    
    func attributedStringConvert(str1:String,str2:String,colorStr1:String,colorStr2:String) -> NSAttributedString {
        let textAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor(hexString: colorStr1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
        let textAttributes2 = [NSAttributedString.Key.foregroundColor: UIColor(hexString: colorStr2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]
        
        let textPartOne = NSMutableAttributedString(string: str1, attributes: textAttributes1)
        let textPartTwo = NSMutableAttributedString(string: str2, attributes: textAttributes2)
        
        let combinedString = NSMutableAttributedString()
        combinedString.append(textPartOne)
        combinedString.append(textPartTwo)
        return combinedString
    }
    
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }



}
