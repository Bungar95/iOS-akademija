//
//  NetworkManager.swift
//  RxMovies
//
//  Created by Borna Ungar on 24.07.2021..
//

import Foundation
import Alamofire
import RxSwift

class NetworkManager{
    
    func getData<T: Codable>(from requestType: RequestUrl) -> Observable<T>{
        
        return Observable.create{ observer in
            let request = AF.request(requestType.url)
                .validate().responseDecodable(of: T.self, decoder: SerializationManager.jsonDecoder){ networkResponse in
                switch networkResponse.result{
                case .success:
                    do{
                        let response = try networkResponse.result.get()
                        observer.onNext(response)
                        observer.onCompleted()
                    }
                    catch(let error){
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
