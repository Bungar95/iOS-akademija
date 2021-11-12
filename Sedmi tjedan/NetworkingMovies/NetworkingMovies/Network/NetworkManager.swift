//
//  NetworkManager.swift
//  NetworkingMovies
//
//  Created by Borna Ungar on 30.06.2021..
//

import Foundation
class NetworkManager {
    let apiid = "?api_key=f7f4dcdbf711ae4096d446df5c212f79"
    func getMovieData(from url: String, _ completed: @escaping (MovieResponse?) -> Void){
        guard let safeUrl = URL(string: url + apiid) else {return}
        URLSession.shared.dataTask(with: safeUrl){ data, urlResponse, error in
            guard let safeData = data, error == nil, urlResponse != nil else {
                print("Error: \(error?.localizedDescription)")
                completed(nil)
                return
            }
            if let decodedObject: MovieResponse = SerializationManager().parse(jsonData: safeData){
                completed(decodedObject)
            }else{
                print("ERROR: palo parsanje \(error)")
                completed(nil)
            }
        }.resume()
    }
    
    func getCreditsData(from url: String, _ completed: @escaping (CreditsResponse?) -> Void){
        guard let safeUrl = URL(string: url + apiid) else {return}
        URLSession.shared.dataTask(with: safeUrl){ data, urlResponse, error in
            guard let safeData = data, error == nil, urlResponse != nil else {
                print("Not safe data")
                completed(nil)
                return
            }
            if let decodedObject: CreditsResponse = SerializationManager().parse(jsonData: safeData){
                completed(decodedObject)
            }else{
                print("ERROR: palo parsanje \(error)")
                completed(nil)
            }
        }.resume()
    }
}
