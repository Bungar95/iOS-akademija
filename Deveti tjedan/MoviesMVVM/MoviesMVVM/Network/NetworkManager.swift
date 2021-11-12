//
//  NetworkManager.swift
//  MoviesMVVM
//
//  Created by Borna Ungar on 14.07.2021..
//

import Foundation
import Alamofire

class NetworkManager{
    var parameters = Parameters()
    
    func getData<T: Codable> (from requestType: RequestUrl, _ completed: @escaping (T?) -> (Void)) {
        AF.request(requestType.url, method: .get)
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
