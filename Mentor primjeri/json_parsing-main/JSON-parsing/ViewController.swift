//
//  ViewController.swift
//  JSON-parsing
//
//  Created by Danijel Trifunović on 22.02.2021..
//

import UIKit

enum DataType {
    case countries
    case crops
    case forecast
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(for: .countries)
    }
    
    private func getData(for type: DataType) {
        switch type {
        case .countries:
            getCountries()
        case .crops:
            getCrops()
        case .forecast:
            getForecast()
        }
    }
}

extension ViewController {
    private func getCountries() {
        if let localData = self.readLocalFile(forName: "Countries"),
           let responseData: Response<[Country]> = parse(jsonData: localData),
           let data = responseData.data {
            print(String(data: localData, encoding: String.Encoding.utf8))
            handleCountries(data: data)
        }
        
    }
    
    private func handleCountries(data: [Country]) {
        
        
        data.forEach { (country) in
            print("Name: \(country.name)")
            print("Code: \(country.code2)")
            
            if let callingCode = country.callingCode {
                print("Calling code: \(callingCode)")
            }
            print("\n")
        }
    }
}

extension ViewController {
    private func getCrops() {
        if let localData = self.readLocalFile(forName: "Crops"),
           let responseData: Response<[CropGroup]> = parse(jsonData: localData),
           let data = responseData.data {
            handleCrops(data: data)
        }
    }
    
    private func handleCrops(data: [CropGroup]) {
        data.forEach { (cropGroup) in
            print("Group name: \(cropGroup.name)")
            
            cropGroup.crops?.forEach({ (crop) in
                print("\tCrop name: \(crop.name)")
                print("\tImage url: \(crop.image.url)")
                
                if let dateTime = crop.updatedAt?.datetime {
                    print("\tUpdated at: \(dateTime)")
                }
                print("\n")
            })
            
            print("\n")
        }
    }
}

extension ViewController {
    private func getForecast() {
        if let localData = self.readLocalFile(forName: "HourlyForecast"),
           let responseData: Response<[ForecastDetails]> = parse(jsonData: localData),
           let data = responseData.data {
            handleForecast(data: data)
        }
    }
    
    private func handleForecast(data: [ForecastDetails]) {
        data.forEach { (details) in
            print("Time: \(DateUtils.getForecastTimeFromTimestamp(timestamp: details.header.time))")
            print("Summary: \(details.header.summary)")
            
            if let temp = details.header.temperature {
                print("\(temp.label): \(temp.value)")
            }
            
            if let windSpeed = details.parameters.first(where: { (dict) -> Bool in
                return dict.key.contains("windSpeed")
            }) {
                print("\(windSpeed.value.label): \(windSpeed.value.value)")
            }
            
            if let pressure = details.parameters.first(where: { (dict) -> Bool in
                return dict.key.contains("pressure")
            }) {
                print("\(pressure.value.label): \(pressure.value.value)")
            }
            
            if let humidity = details.parameters.first(where: { (dict) -> Bool in
                return dict.key.contains("humidity")
            }) {
                print("\(humidity.value.label): \(humidity.value.value)")
            }
            
            print("\n")
        }
    }
}

extension ViewController {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }

    private func parse<T: Codable>(jsonData: Data) -> T?{
        let object: T?
        do {
            object = try ViewController.jsonDecoder.decode(T.self, from: jsonData)
            
        } catch {
            print("decode error")
            object = nil
        }
        return object
    }
}
