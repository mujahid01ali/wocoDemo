//
//  AFWrapper.swift
//  smartplaykid
//
//  Created by Mushareb Ali on 08/10/18.
//  Copyright © 2018 Mushareb Ali. All rights reserved.
//
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
class AFWrapper: NSObject {
    

    
   
    
    class func requestGETURL<T: Mappable>(url : String,headers:[String:Any],success:@escaping (_ response: T) -> Void, failure:@escaping (Error) -> Void){
        Alamofire.request(url, method : .get,headers: headers as? HTTPHeaders)
        .authenticate(user: "admin", password: "1234")
            .responseObject { (response: DataResponse<T>) in
            let responseResult = response.result.value
            print("url : \(response.request!)" as Any)
            switch response.result {
            case .success:
                success(responseResult!)

                break;
            case .failure(let error):
                failure(error  )
                break;
            }
        }


    }
    
    
    class func requestGETURLPost<T: Mappable>(url : String,headers:[String:Any],param:[String:Any],success:@escaping (_ response: T) -> Void, failure:@escaping (Error) -> Void){
        Alamofire.request(url, method : .post,parameters: param,headers: headers as? HTTPHeaders )
        .authenticate(user: "admin", password: "1234")
            .responseObject { (response: DataResponse<T>) in
            let responseResult = response.result.value
            print("url : \(response.request!)" as Any)
            switch response.result {
            case .success:
                success(responseResult!)

                break;
            case .failure(let error):
                failure(error  )
                break;
            }
        }


    }
    
 
    
    
    
}
