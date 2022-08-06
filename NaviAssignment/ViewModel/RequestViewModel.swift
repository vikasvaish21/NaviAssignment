//
//  RequestViewModel.swift
//  NaviAssignment
//
//  Created by Vikas Vaish on 06/08/22.
//

import Foundation

class RequestViewModel{
    
    // MARK: - Fetch data For closed request
    
    func fetchData(_ username: String, _ repoName: String, completionHandler: @escaping (DataModel, Bool, String?) -> Void){
        NetworkingManager.shared.fetchData(username, repoName){response, success, error  in
            print(response)
            if success == true{
                completionHandler(response, true, nil)
            }else{
                completionHandler(response, false, error)
            }
        }
    }
}
