//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit


class ViewController: UIViewController , UIPickerViewDataSource , UIPickerViewDelegate , CoinManagerDelegate
{
    
    var coinManager = CoinManager()                        // created an object which is pointing to the struct coinManager to access its properties
    
    

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {                     // determines the number of coloumns we want in our pickerview
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int  // counting the number of fields or entries we want                                                                                                                             in our pickerview
    {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? //this func will display the row title                                                                                                    in pickerview by passing in the row values
    {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {  // passes the value or name of the selected row
        
        let currency = coinManager.currencyArray[row]
        
        print(currency)
        coinManager.getCoinPrice(for: currency)
    }
    
    func didUpdateCoin(_ coinManager : CoinManager ,coin: CoinModel) {
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.currencyRateString
            self.currencyLabel.text = coin.currencyName
        }
       
    }

    func didFail(error: Error) {
        print(error)
    }
    

}

