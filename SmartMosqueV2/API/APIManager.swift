////
////  APIManager.swift
////  SmartMosqueV2
////
////  Created by Rizo iMac on 04/03/20.
////  Copyright © 2020 Rizo Corp. All rights reserved.
////
//
//import Foundation
//
//protocol APIManagerDelegate {
//    func didObtainResponse(_ apiManager: APIManager, apiResponse: APIResponseModel)
//    func didFailWithError(error: Error)
//}
//
//struct APIManager {
//
//    var delegate: APIManagerDelegate?
//
//    //MARK: - List of APIs
//
//    func fetchCountryList() {
//        let urlString = K.baseURL + K.Environment.apiLiveUrl + K.EndPoints.countryEP
//        performRequest(with: urlString)
//    }
//
//    //MARK: - Send & Parse http requests
//
//    func performRequest(with urlString: String) {
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
//                    return
//                }
//                if let safeData = data {
//                    print (String(data: safeData, encoding: .utf8)!)
//                    if let response = self.parseJSON(safeData) {
//                        // print(response)
//                        self.delegate?.didObtainResponse(self, apiResponse: response)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func parseJSON(_ response: Data) -> APIResponseModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(APIResponseModel.self, from: response)
//            // let response = decodedData.response
//            // let resultSet = decodedData.resultSet
//            // print(decodedData)
//            return decodedData
//        } catch {
//            print("inside decoding error")
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//}
