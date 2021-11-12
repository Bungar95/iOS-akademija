//
//  NetworkManager.swift
//  MVVM_architecture_example
//
//  Created by Zvonimir Medak on 02.03.2021..
//

import Foundation
import Alamofire

class NetworkManager{
    var parameters = Parameters()
    
    
    func getData<T: Codable> (from url: String, _ completed: @escaping (T?) -> (Void)) {
        parameters["apiid"] = "api_key=42a87c57062b676b711b718b0e1c3bf8"
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self, decoder: SerializationManager.jsonDecoder) { (response) in
                switch response.result {
                case .success(let result):
                    completed(result)
                case .failure(let error):
                    print(error.localizedDescription)
                    completed(nil)
                }
            }
    }
}
