//
//  Constants.swift
//  SmartMosqueV2
//
//  Created by Rizo iMac on 04/03/20.
//  Copyright © 2020 Rizo Corp. All rights reserved.
//

import Foundation

struct K {
    
    static let appName = "Smart Mosque V2"
    static let baseURL = "https://smartcloudpaper.com/"
    
    struct Environment {
        //        static let apiLiveClientUrl = "SmartMosqueAPIQC/" //clientLive
        static let apiLocalURL = "SmartMosqueAPI/" //local
        static let apiDevUrl = "SmartMosqueAPIDev/" //dev
        static let apiLiveUrl = "SmartMosqueAPIQC/" //live
    }
    
    struct EndPoints {
        static let countryEP = "SMGetCountry.php"
        static let cityEP = "SMGetCity.php"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
}
