//
//  NetworkManager.swift
//  NetworkingMoviesCocoa
//
//  Created by Borna Ungar on 06.07.2021..
//
import Alamofire
import Foundation
class NetworkManager {
    
    let jsonDecoder = SerializationManager.jsonDecoder
        
        func getMovieData(for requestUrl: MovieRelatedUrl, _ completed: @escaping (MovieResponse?) -> Void){
            
            guard let safeUrl = URL(string: requestUrl.url) else {return}
            let request = AF.request(safeUrl)
            
            request.responseDecodable(of: MovieResponse.self, decoder: jsonDecoder){ response in
                switch response.result {
                case .success:
                    guard let movies = response.value else {
                        print(response.error ?? "Unknown error")
                        completed(nil)
                        return
                    }
                    completed(movies)
                case .failure(let error):
                    print(error)
                    completed(nil)
                }
            }.resume()
        }
        
        func getCreditsData(for requestUrl: MovieRelatedUrl, _ completed: @escaping (CreditsResponse?) -> Void){
            guard let safeUrl = URL(string: requestUrl.url) else {return}
            let request = AF.request(safeUrl)
            
            request.responseDecodable(of: CreditsResponse.self, decoder: jsonDecoder){ response in
                switch response.result {
                case .success:
                    guard let credits = response.value else {
                        print(response.error ?? "Unknown error")
                        completed(nil)
                        return
                    }
                    completed(credits)
                case .failure(let error):
                    print(error)
                    completed(nil)
                }
            }.resume()
        }
    }
