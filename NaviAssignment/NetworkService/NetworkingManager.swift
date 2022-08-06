//
//  NetworkingManager.swift
//  NaviAssignment
//
//  Created by Vikas Vaish on 06/08/22.
//

import Foundation
import Alamofire

class NetworkingManager {
    
    static var shared = NetworkingManager()
    
    var dataModel: DataModel?
    
    //MARK: Build URL
    private func fetchURL(inputURL: String) -> String{
        let baseUrl = Constants.NetworkingConstants.baseUrl
        let endUrl = Constants.NetworkingConstants.endUrl
        let finalUrl = baseUrl + inputURL + endUrl
        return finalUrl
    }
    
    //MARK:  API Request For Fetch Pull Request
    func fetchData(_ username: String, _ repoName: String, completionHandler: @escaping (DataModel, Bool, String?) -> Void) {
        let inputUrl = username + "/" + repoName
        let url = fetchURL(inputURL: inputUrl)
        let request = AF.request(url)
        request.responseDecodable(of: DataModel.self){ response in
            print(response)
            switch response.result{
            case .success(let requestData):
                self.dataModel = requestData
                completionHandler(requestData, true, "Success")
            case .failure(_):
                print(response.error ?? "Failure")
                completionHandler(self.dataModel ?? DataModel() , false, "Failure")
                self.dataModel = nil
            }
        }
    }
    
    //MARK: Fetch image Data
    func getImage(_ url: String,completionHandler: @escaping (UIImage?,String?) -> Void)  {
        let request = AF.request(url)
        request.responseData{ response in
            switch response.result{
            case .success:
                guard let imageData = response.value,let image = UIImage(data: imageData,scale: 1.0) else{
                    return
                }
                completionHandler(image,nil)
            case .failure(let error):
                completionHandler(nil,error.errorDescription)
            }
        }
    }
    
   
}
