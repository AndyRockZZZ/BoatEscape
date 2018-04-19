//
//  startscreen.swift
//  AndrewDevine_Coursework
//
//  Created by ad15abk on 15/04/2018.
//  Copyright © 2018 AndrewDevine. All rights reserved.
//

import UIKit

class startscreen: UIViewController{
    
    @IBOutlet weak var boatpass: UIImageView!
    
    func boatanimation() {
        self.boatpass.center.x = -50
        UIView.animate(withDuration: 5, delay: 0.0, options: [UIViewAnimationOptions.repeat, .curveLinear], animations:
            {
                self.boatpass.center.x += 700
                if self.boatpass.center.x >= 700 {
                    self.boatpass.center.x = 0
                }
                
                
        }, completion: nil
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        boatanimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
