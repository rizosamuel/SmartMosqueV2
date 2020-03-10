//
//  GetCountriesAPI.swift
//  SmartMosqueV2
//
//  Created by Rizo iMac on 05/03/20.
//  Copyright © 2020 Rizo Corp. All rights reserved.
//

import Foundation

protocol GetCountriesAPIDelegate {
    func didObtainCountries(countryResponse: CountryModel)
    func didFailToObtainCountriesError(error: Error)
}

struct GetCountriesAPI {
    
    var delegate: GetCountriesAPIDelegate?
    
    func fetchCountryList() {
        let urlString = K.baseURL + K.Environment.apiLiveUrl + K.EndPoints.countryEP
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailToObtainCountriesError(error: error!)
                    return
                }
                if let safeData = data {
                    print (String(data: safeData, encoding: .utf8)!)
                    if let response = self.parseJSON(safeData) {
                        // print(response)
                        self.delegate?.didObtainCountries(countryResponse: response)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ response: Data) -> CountryModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CountryModel.self, from: response)
            return decodedData
        } catch {
            delegate?.didFailToObtainCountriesError(error: error)
            return nil
        }
    }
}
