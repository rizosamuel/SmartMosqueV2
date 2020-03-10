//
//  GetStatesAPI.swift
//  SmartMosqueV2
//
//  Created by Rizo iMac on 05/03/20.
//  Copyright © 2020 Rizo Corp. All rights reserved.
//

import Foundation

protocol GetCitiesAPIDelegate {
    func didObtainCities(cityResponse: CityModel)
    func didFailToObtainCitiesError(error: Error)
}

struct GetCitiesAPI {
    
    var delegate: GetCitiesAPIDelegate?
    
    func fetchCityList() {
        let urlString = K.baseURL + K.Environment.apiLiveUrl + K.EndPoints.cityEP
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
//            let parameterDictionary = ["CountryId" : "1"]
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
         
            let httpBody = "CountryId=1".data(using:String.Encoding.ascii, allowLossyConversion: false)
           
            request.httpBody = httpBody
            //hello for commit
            
           let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailToObtainCitiesError(error: error!)
                    return
                }
                
                print("response: ", response!)
                
                if let safeData = data {
                    print (String(data: safeData, encoding: .utf8)!)
                    if let response = self.parseJSON(safeData) {
                        // print(response)
                        self.delegate?.didObtainCities(cityResponse: response)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ response: Data) -> CityModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CityModel.self, from: response)
            return decodedData
        } catch {
            delegate?.didFailToObtainCitiesError(error: error)
            return nil
        }
    }
}
