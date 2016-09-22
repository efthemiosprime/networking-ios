//
//  ViewController.swift
//  nsurlsession-swift
//
//  Created by Efthemios Prime on 9/21/16.
//  Copyright © 2016 Efthemios Prime. All rights reserved.
//

import UIKit


struct Weather {
    
    let cityName: String
    let temperature: Double
    let description: String
    
    init(cityName: String, temperature: Double, description: String) {
        self.cityName = cityName
        self.temperature = temperature
        self.description = description
        
    }
}


class ViewController: UIViewController {

    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawCard()
        self.view.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)

        let session = NSURLSession.sharedSession()
        let newyorkWeatherURL = "http://api.openweathermap.org/data/2.5/weather?q=Newyork,ny&APPID=4e4dc0f63b414becd724329cdd249b3e"
        
        guard let url = NSURL(string: newyorkWeatherURL) else {
            return print("Error: not a valid url")
        }
        
        let urlRequest = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            // check for any errros
            guard error == nil else {
                print("error calling GET on weather?q=Newyork,ny")
                print (error)
                return
            }
            
            // check data
            guard let weatherData = data else {
                print("Error: no data")
                return
            }
            
            do {
                guard let nyData = try NSJSONSerialization.JSONObjectWithData(weatherData, options: []) as? NSDictionary else {
                    print("error converting to JSON")
                    return
                }

                let temp = nyData["main"]!["temp"]??.doubleValue
                let celcius = temp! - 273.15
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.card!.cityLabel?.text = String(celcius) + "°"
                })

            }catch {
                
            }
            
        }
        

        
        task.resume()
    }
    
    func drawCard() -> Void {
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        
        card = Card(frame: CGRect(x: 0, y: 10, width: width-20, height: 80))
        card!.center.x = self.view.center.x
        self.view.addSubview(card!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

