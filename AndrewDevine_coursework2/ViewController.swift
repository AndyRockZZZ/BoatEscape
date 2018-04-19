//
//  ViewController.swift
//  AndrewDevine_coursework2
//
//  Created by ad15abk on 25/02/2018.
//  Copyright © 2018 AndrewDevine. All rights reserved.
//

import UIKit

protocol subviewDelegate {
    
}

class ViewController: UIViewController, subviewDelegate{
    

    @IBOutlet weak var roadimage: UIImageView!
    @IBOutlet weak var mycar: movingvehicle!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mycar.myDelegate = self
        
        var imagearray: ([UIImage])!
       
        
        imagearray = [UIImage(named: "road1.png")!,
                      UIImage(named: "road2.png")!,
                      UIImage(named: "road3.png")!,
                      UIImage(named: "road4.png")!,
                      UIImage(named: "road5.png")!,
                      UIImage(named: "road6.png")!,
                      UIImage(named: "road7.png")!,
                      UIImage(named: "road8.png")!,
                      UIImage(named: "road9.png")!,
                      UIImage(named: "road10.png")!,
                      UIImage(named: "road11.png")!,
                      UIImage(named: "road12.png")!,
                      UIImage(named: "road13.png")!,
                      UIImage(named: "road14.png")!,
                      UIImage(named: "road15.png")!,
                      UIImage(named: "road16.png")!,
                      UIImage(named: "road17.png")!,
                      UIImage(named: "road18.png")!,
                      UIImage(named: "road19.png")!,
                      UIImage(named: "road20.png")!,]
        
        roadimage.image = UIImage.animatedImage(with: imagearray, duration: 0.5)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

