//
//  Card.swift
//  nsurlsession-swift
//
//  Created by Efthemios Prime on 9/21/16.
//  Copyright © 2016 Efthemios Prime. All rights reserved.
//

import UIKit

public class Card: UIView {
    
    var cityLabel: UILabel?

    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: frame, cornerRadius: 5).CGPath
        layer.fillColor = UIColor(red: 137/255, green: 146/255, blue: 159/255, alpha: 1.0).CGColor
        self.layer.addSublayer(layer)
        
        cityLabel = UILabel(frame: CGRect(x: 15, y: frame.size.height/2, width: 200, height: 20))
        cityLabel?.font = UIFont(name: "Roboto-Bold", size: 20.0)
        cityLabel?.textColor = UIColor.whiteColor()
        self.addSubview(cityLabel!)
        
        
        let icon = UIImageView(image: UIImage(named: "images/sunny"))
        icon.frame.size = CGSizeMake(44, 44)
        icon.frame.origin.x = frame.size.width - 60
        icon.center.y = self.center.y
        
        self.addSubview(icon)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
