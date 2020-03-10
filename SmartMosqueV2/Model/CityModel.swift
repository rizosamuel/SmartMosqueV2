//
//  StateModel.swift
//  SmartMosqueV2
//
//  Created by Rizo iMac on 05/03/20.
//  Copyright © 2020 Rizo Corp. All rights reserved.
//

import Foundation

struct CityModel: Codable {
    let Response: [GetCitiesResponse]
    let ResultSet: [GetCitiesResult]
}

struct GetCitiesResponse: Codable {
    let ERROR_CODE: String
    let ERROR_MSG: String
}

struct GetCitiesResult: Codable {
    let CITY_ID: String
    let CITY_NAME: String
}
