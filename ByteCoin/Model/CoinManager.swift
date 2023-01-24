//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate
{
    func didUpdateCoin(_ coinManager : CoinManager ,coin : CoinModel)
    func didFail(error : Error)
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = ""
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String)
    {
        let urlString = ("\(baseURL)/\(currency)?apikey=\(apiKey)")
        performRequest(with: urlString)
        
        
    }
    
    func performRequest(with urlForFunc : String)
    {
        //1. Create A Url using URL struct using URL(string : )
        
       if let url = URL(string: urlForFunc)
        {
           
           // 2. Create a URLSession using URL(config : )
           
           let session = URLSession(configuration: .default)
           
           // 3. Give The Session A Task
           
           let task = session.dataTask(with: url) { data , response , error in
               
               if ( error != nil)
               {
                   self.delegate?.didFail(error: error!)
                  return // exits the whole func i.e completion handler
               }
               
               if let safedata = data
               {
                  if let coin = self.parseJSON(safedata)
                   {
                      self.delegate?.didUpdateCoin(self,coin : coin)                     //inside a closure use self
                      
                  }
                   
                   // sending the data To JSON to get decoded , always use self. while calling a func or while using a func otherwise the code will not work, i've created the coin constant because the func parseJSON will return an output in the form of CoinModel to catch it ive created it , the output from parseJSON can be an optional so to use it ive used optional binding
               }
               
               
           }
           
           //4. Start The Task
           
            task.resume()                                                                               //read the description option+hover
       }
        
    }
    
    func parseJSON(_ coinData : Data) -> CoinModel?
    {
        // to parse the data we have to tell our compiler that how the data is structured and for that we will always have to create an struct for it
        
        
        let decoder = JSONDecoder()                                                                              // creating a decoder of type JSON
        
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)      //takes 2 input the data we want to decode and the decodeable type which means we have to specify in our struct coindata that it is of decodable protocol, but it is an object and we need a type so to define a type we have used .self with coindata . This can throw an error to handle the error we must keep it in a try catch block. Decode method gives an output in the form of an object which will be of type struct Coindata 
            
            let selectedCoinName = decodedData.asset_id_quote  //have holded the decoded data so that it can be passed into the coin object that i                                                                                                          will create using coin model
            let currencyRate = decodedData.rate
            
            let coin = CoinModel(currencyName: selectedCoinName, conversionRate: currencyRate)         //we've created coin object from CoinModel
            
            //now i want to return it to parseJSON on line 49  as i have decoded the needed data
            
            return coin  // what if the parsing did'nt go according to the plan and ended with an error then it will skip the do block code and go to              the catch block
            
        }
        catch
        {
            delegate?.didFail(error: error)
            return nil
        }
    }

    
}
