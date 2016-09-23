//
//  ViewController.swift
//  alamofire-swiftyjson
//
//  Created by Efthemios Prime on 9/22/16.
//  Copyright © 2016 Efthemios Prime. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


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

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    // GET
    // =======================================================================
    func goGET() -> Void {
        
        let endpoint = "http://reqres.in/api/users/1"
        Alamofire.request(.GET, endpoint)
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    print("error calling GET")
                    return
                }
                
                guard let value = response.result.value else  {
                    print("no result data")
                    return
                }
                
                

                let userJSON = JSON(value)["data"]
                
                let user : User = User(firstName: userJSON["first_name"].string!, lastName: userJSON["last_name"].string!, avatar: userJSON["avatar"].string!)
                
                let avatarURL = NSURL(string: user.avatar)
                let avatarData = NSData(contentsOfURL: avatarURL!)
                dispatch_async(dispatch_get_main_queue(), {
                    self.fullNameLabel.text = user.firstName + " " + user.lastName
                    
                    self.avatarImageView.image = UIImage(data: avatarData!)
                    
                    
                })
        }
    }
    

    @IBAction func getHandler(sender: AnyObject) {
        goGET()
    }
    
    // POST
    // =======================================================================
    func goPOST() -> Void {
        
        let endpoint: String = "http://reqres.in/api/users"
        let newUser = ["name": "Efthemios", "job" : "Blacksmith"]
        
        Alamofire.request(.POST, endpoint, parameters: newUser, encoding: .JSON)
            .responseJSON { response in
                guard response.result.error  == nil else {
                    print("Error calling POST")
                    print(response.result.error!)
                    return
                }
                
                guard let value = response.result.value else {
                    print("no result recieved")
                    return
                }
                
                
                let user = JSON(value)
                print(user)
                
            
        }

    
    }
    @IBAction func postHandler(sender: AnyObject) {
        goPOST()
    }
    
    // POST
    // =======================================================================
    func goDELETE() -> Void {
        let endpoint: String = "http://reqres.in/api/users/2"
        
        Alamofire.request(.DELETE, endpoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("error calling DELETE")
                    print(response.result.error)
                    return
                }
                
                print("DELETED")
        }
    }
    @IBAction func deleteHandler(sender: AnyObject) {
        goDELETE()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

