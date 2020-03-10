//
//  CountryModel.swift
//  SmartMosqueV2
//
//  Created by Rizo iMac on 04/03/20.
//  Copyright © 2020 Rizo Corp. All rights reserved.
//

import Foundation

struct CountryModel: Codable {
    let Response: [GetCountriesResponse]
    let ResultSet: [GetCountriesResult]
}

struct GetCountriesResponse: Codable {
    let ERROR_CODE: String
    let ERROR_MSG: String
}

struct GetCountriesResult: Codable {
    let COUNTRY_ID: String
    let COUNTRY_NAME: String
}
