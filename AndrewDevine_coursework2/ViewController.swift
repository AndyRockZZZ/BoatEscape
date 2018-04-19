//
//  ViewController.swift
//  AndrewDevine_coursework2
//
//  Created by ad15abk on 25/02/2018.
//  Copyright © 2018 AndrewDevine. All rights reserved.
//

import UIKit

protocol subviewDelegate {
    func changesomething()
}

class ViewController: UIViewController, subviewDelegate, UICollisionBehaviorDelegate{
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var gameover: UIImageView!

    @IBOutlet weak var roadimage: UIImageView!

    @IBOutlet weak var replaybutton: UIButton!
    @IBOutlet weak var mycar: movingvehicle!
    
    var dynamicAnimator: UIDynamicAnimator!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    var collisionbehavior: UICollisionBehavior!
    var gravitybehavior: UIGravityBehavior!
    
    var obstacle: [UIImageView] = []
    
    @IBAction func replay() {
        viewDidLoad()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mycar.myDelegate = self
        collisionbehavior = UICollisionBehavior()
        collisionbehavior.addBoundary(withIdentifier: "Barrier" as NSCopying, for: UIBezierPath(rect: mycar.frame))
        collisionbehavior.collisionDelegate = self
        
        var imagearray: ([UIImage])!
        self.background.backgroundColor = UIColor.black
        self.replaybutton.isHidden = true
        self.background.isHidden = true
        self.gameover.isHidden = true
        
        gravitybehavior = UIGravityBehavior()
        dynamicItemBehavior = UIDynamicItemBehavior()
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
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
        
        let start = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: start) {
            
              let delay = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.carspawn), userInfo: nil, repeats: true)
            
            let finish = DispatchTime.now() + 20
            DispatchQueue.main.asyncAfter(deadline: finish) {
                self.background.isHidden = false
                self.mycar.isHidden = false
                self.gameover.isHidden = false
                self.replaybutton.isHidden = false
                
                self.view.bringSubview(toFront: self.gameover)
                self.view.bringSubview(toFront: self.background)
                self.view.bringSubview(toFront: self.replaybutton)
                
                delay.invalidate()
                for vehicle in self.obstacle{
                    self.collisionbehavior.removeItem(vehicle)
                    vehicle.removeFromSuperview()
                    
                }

            }
        }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func carspawn(){
        
        var cararray = ["car1.png", "car2.png", "car3.png", "car4.png", "car5.png"]
        let randomcar = Int(arc4random_uniform(UInt32(cararray.count))) + 1
        var shuffled = [String]()
        let carimageview = UIImageView(image: nil)
        
        
        let lower: UInt32 = 52
        let upper: UInt32 = 273
        let randomx = Int(arc4random_uniform(UInt32(upper - lower))) + 52
        
        for i in 1...randomcar {
            let rand = Int(arc4random_uniform(UInt32(cararray.count)))
            shuffled.append(cararray[rand])
            cararray.remove(at: rand)
        }
        
        for index in 1...randomcar{
            
            // declaring the obstacle cars as an image view.
            
            let carimage = UIImage(named: shuffled[index - 1])
            let carimageview = UIImageView(image: carimage)
            carimageview.frame = CGRect(x: (randomx * index), y: 0, width: 35, height: 57)
            self.view.addSubview(carimageview)
            obstacle.append(carimageview)
            
            
            // adding the gravity behavior into the new array to display more than one obstacle car at the same time.
            
            dynamicItemBehavior.addItem(carimageview)
            
            self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: 0, y: 300), for: carimageview)
            
            dynamicAnimator.addBehavior(dynamicItemBehavior)
            
            // collision behaviour with the delay of the main car and obstacle cars to crash.
            
            collisionbehavior.addItem(carimageview)
            dynamicAnimator.addBehavior(collisionbehavior)
            
        }
        
    }

    func changesomething() {
        
        collisionbehavior.removeAllBoundaries()
        collisionbehavior.addBoundary(withIdentifier: "Barrier" as NSCopying, for: UIBezierPath(rect: mycar.frame))
    }
}

