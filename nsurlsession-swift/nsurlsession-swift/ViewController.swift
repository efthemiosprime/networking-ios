//
//  ViewController.swift
//  nsurlsession-swift
//
//  Created by Efthemios Prime on 9/21/16.
//  Copyright © 2016 Efthemios Prime. All rights reserved.
//

import UIKit

struct User {
    let firstName: String
    let lastName: String
    let avatar: String
    
    init(firstName: String, lastName: String, avatar: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        
    }
    
    // GET 
    // =======================================================================
    func goGet() -> Void {
        
        let session = NSURLSession.sharedSession()
        let endpoint = "http://reqres.in/api/users/1"
        
        fullNameLabel.textColor = UIColor.whiteColor()
        fullNameLabel.font = UIFont(name: "Roboto-Bold", size: 14)
        
        guard let url = NSURL(string: endpoint) else {
            return print("Error: not a valid url")
        }
        
        let urlRequest = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            // check for any errros
            guard error == nil else {
                print("error calling GET")
                print (error)
                return
            }
            
            // check data
            guard let weatherData = data else {
                print("Error: no data")
                return
            }
            
            do {
                guard let userJSON = try NSJSONSerialization.JSONObjectWithData(weatherData, options: []) as? NSDictionary else {
                    print("error converting to JSON")
                    return
                }
                
                print("===========================")
                guard let userData = userJSON["data"] as? NSDictionary else {
                    print("Could not convert to NSDictionary")
                    return
                }
                
                let user: User = User(firstName: userData["first_name"]! as! String,
                                      lastName: userData["last_name"]! as! String,
                                      avatar: userData["avatar"]! as! String)
                
                
                if let avatarURL = NSURL(string: user.avatar) {
                    if let data = NSData(contentsOfURL: avatarURL) {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.avatarImage.image = UIImage(data: data)

                        })
                    }
                }
                
                    dispatch_async(dispatch_get_main_queue(), {
                        self.fullNameLabel.text = user.firstName + " " + user.lastName
                    })

                
            }catch {
                print("error trying to convert data to JSON")
            }
            
        }
        
        task.resume()
    }

    // POST
    // =======================================================================
    func goPOST() -> Void {
        
        let endpoint: String = "http://reqres.in/api/users"
        
        guard let url = NSURL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = "POST"
        
        let newUser = ["name": "Efthemios", "job" : "Blacksmith"]
        let userJSON: NSData
        do{
            userJSON = try NSJSONSerialization.dataWithJSONObject(newUser, options: [])
            urlRequest.HTTPBody = userJSON
        }catch {
            print("Error: cannot create JSON from user")
        }
        
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            // check error
            guard error == nil else {
                print("Error: POST")
                return
            }
            
            // check data
            guard let userData = data else {
                print("no data")
                return
            }
            
            // success
            print("===================================")
            print("POST SUCCESS RESONSE")
            print(response)
            
            
            do {
                guard let userJSON = try  NSJSONSerialization.JSONObjectWithData(userData, options: []) as? NSDictionary else {
                    print("error converting to JSON")
                    return
                }
                
                print("===================================")
                print("POST SUCCESS DATA")
                print(userJSON)
                
            }catch {
                print("error trying to convert data to JSON")
            }


            
        }
        task.resume()
        
        
    }
    
    
    @IBAction func getHandler(sender: AnyObject) {
        goGet()
    }
    
    
    @IBAction func postHandler(sender: AnyObject) {
        goPOST()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

