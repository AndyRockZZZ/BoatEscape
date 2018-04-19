//
//  movingvehicle.swift
//  AndrewDevine_coursework2
//
//  Created by ad15abk on 25/02/2018.
//  Copyright © 2018 AndrewDevine. All rights reserved.
//

import UIKit

class movingvehicle: UIImageView {
    
    var startlocation: CGPoint?
    var myDelegate: subviewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        startlocation = touches.first?.location(in: self)
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let currentlocation = touches.first?.location(in: self)
        
        let dx = currentlocation!.x - startlocation!.x
        let dy = currentlocation!.y - startlocation!.y
        
        self.center = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
