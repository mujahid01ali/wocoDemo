//
//  SearchLocationCell.swift
//  WoCoDemo
//
//  Created by Mujahid on 27/02/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit
protocol SearchLocationCellDelegate {
    func onClick(visitData:Datum)
}

class SearchLocationCell: UITableViewCell {
    //@IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lbLocation: UILabel!
    var visitData:Datum!
    var delegate:SearchLocationCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // btnSelect.isSelected = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(onPressed))
        lbLocation.isUserInteractionEnabled = true
        lbLocation.addGestureRecognizer(tap)
        
    }
    
    @objc func onPressed(){
        delegate?.onClick(visitData: visitData)
    }
    func setData(response:Datum) {
        visitData = response
        lbLocation.text = "   "+response.title
       // btnSelect.setIconLableLeft(string: "  "+str, image: "ic_radio_uncheck")
    }
//    @IBAction func btnPressed(_ sender: Any) {
//        delegate?.onClick()
////        if btnSelect.isSelected == true{
////            btnSelect.isSelected = false
////            btnSelect.setIconLableLeft(string: "  "+strLoc, image: "ic_radio_uncheck")
////        }else if btnSelect.isSelected == false{
////            btnSelect.isSelected = true
////            btnSelect.setIconLableLeft(string: "  "+strLoc, image: "ic_radio_check")
////            delegate?.onClick()
////        }
//    }
    
}
