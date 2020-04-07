//
//  CheckInInitiateVC.swift
//  WoCoDemo
//
//  Created by Mujahid on 27/02/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit
import Alamofire

class CheckInInitiateVC: BaseVC{

    @IBOutlet weak var imgCross: UIImageView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lbCheckedInLoc: UILabel!
    @IBOutlet weak var lbCurrentTime: UILabel!
    @IBOutlet weak var tvComment: PlaceholderText!
    @IBOutlet weak var mainView: UIView!
    var strLoc:String = ""
    var currentTime:String = ""
    var vc:SearchVC?
    var vistData = Datum()
    var chekinReponse = ChekinReponse()
    override func viewDidLoad() {
        super.viewDidLoad()
        tvComment.placeholder = "Write Here!"
        mainView.roundCorners([.allCorners], radius: 8.0)
        btnSubmit.setTitle("Submit", for: .normal)
        btnSubmit.layer.cornerRadius = 8.0
        getCurremntTime()
        setViewData()
        tvComment.addDoneButtonOnKeyboard()
        let tapCross = UITapGestureRecognizer(target: self, action: #selector(closeView))
        imgCross.isUserInteractionEnabled = true
        imgCross.addGestureRecognizer(tapCross)
        
    }
    @objc func closeView(){
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func getCurremntTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        currentTime = formatter.string(from: Date())
    }
    
    func setViewData() {
        lbCheckedInLoc.attributedText =  attributedStringConvert(str1: "You are Check-in at ", str2: vistData.title, colorStr1: "#000000", colorStr2: "#0077b3")
        lbCurrentTime.text = currentTime
    }

    @IBAction func btnSubmit(_ sender: Any) {
        let url = "http://dev.woco.co.in/api-v1/checkin"
        let headers: HTTPHeaders = [
                "AccessToken": "ODhLTDdKNDdBMlZURDE4WUlFMDZZOTJMVVZDN1RYQ042Q0haV0g5NlNKQjY1SkpBMVRVVFZTQk0zR1pHMjUwQw",
            "Accept": "application/json"
        ]
        
        
        let latitude = defaults.string(forKey: Constant.LAT)
        let long = defaults.string(forKey: Constant.LNG)
        let timeStamp = Date().currentTimeMillis()
        print(timeStamp)
        if !latitude!.isEmpty && !long!.isEmpty {
            if tvComment.text != nil && !tvComment.text.isEmpty {
                let param = [Constant.CHECK_IN_TIMESTAMP:timeStamp,Constant.CHECK_IN_LAT:latitude!,Constant.CHECK_IN_LANG:long!,Constant.CHECK_IN_TYPE:"MANUAL",Constant.CHECK_IN_COMMENT:String(tvComment.text),Constant.DEVICE_ID:"8cbbf6c6cf8e0247"
                    ] as [String : Any]
                setParamPost(url: url, headers: headers, param: param as [String : Any], className: ChekinReponse.self)
                
            }else{
                showToast(message: "Please write comment", seconds: 2.0)
            }
        }else{
                showToast(message: "Please enable Location", seconds: 2.0)
            }
        
        
        
        
        
        
        
    }
    
    override func onSuccessResponse(response: Any) {
        chekinReponse = ChekinReponse()
        chekinReponse = response as! ChekinReponse
        if chekinReponse.status == 200{
            if chekinReponse.data != nil {
                vc?.onCheckin(response: chekinReponse.data)
            }
            showToast(message: chekinReponse.message)
            
            dismiss(animated: false, completion: nil)
        }else{
            showToast(message: chekinReponse.message)
            dismiss(animated: false, completion: nil)
        }

    }
    override func onFailResponse(response: Error) {
        showToast(message: response.localizedDescription)
        dismiss(animated: false, completion: nil)
    }
    

    

}
extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
