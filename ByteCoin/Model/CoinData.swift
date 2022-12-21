//
//  CoinData.swift
//  ByteCoin
//
//  Created by Anurag Bhatt on 04/12/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

// this struct is to tell the compiler how the data is structered in JSON format

struct CoinData : Codable                                 //it can decode itself from the JSON represntation to the swift compatible representation
{
    let asset_id_base : String
    let asset_id_quote : String
    let rate : Double
}
