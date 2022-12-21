//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Anurag Bhatt on 06/12/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

// this struct is created to model how the coin object should look like 

struct CoinModel
{
    let currencyName : String
    let conversionRate : Double
    
    var currencyRateString : String
    {
        return String(format: "%0.2f", conversionRate)
    }
}
