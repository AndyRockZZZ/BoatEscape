//
//  ViewController.swift
//  AndrewDevine_Coursework
//
//  Created by ad15abk on 25/02/2018.
//  Copyright © 2018 AndrewDevine. All rights reserved.
//

import UIKit
import AVFoundation

protocol subviewDelegate {
    func changesomething()
}

class ViewController: UIViewController, subviewDelegate,
    UICollisionBehaviorDelegate{
    
    @IBOutlet weak var boat: movingvehicle!
    @IBOutlet weak var gameover: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var scoretitle: UILabel!
    @IBOutlet weak var finalscore: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var riverarray: UIImageView!
    @IBOutlet weak var replaybutton: UIButton!
    
    var dynamicAnimator: UIDynamicAnimator!
    
    var dynamicItemBehavior: UIDynamicItemBehavior!
    var collisionbehavior: UICollisionBehavior!
    var gravitybehavior: UIGravityBehavior!
    var backgroundmusic: AVAudioPlayer?
    var gameovermusic: AVAudioPlayer?
    
    var count: Int = 0
    var scorenumber = 0
    
    var obstacle: [UIImageView] = []
    
    let screensize = UIScreen.main.bounds
    var screenwidth: CGFloat?
    
    //var timesReplayed = 0
    
    @IBAction func replay() {
        viewDidLoad()
        count = 0
        scorenumber = 0
        score.text = String(scorenumber)
        //timesReplayed += 1
    }
    
    @objc(collisionBehavior:beganContactForItem:withBoundaryIdentifier:atPoint:) func collisionBehavior(_ behavior: UICollisionBehavior,beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint){
        
        scorenumber = scorenumber - 1
        score.text = String(scorenumber)
        finalscore.text = (score.text! + " Points")
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        boat.myDelegate = self
        collisionbehavior = UICollisionBehavior()
        collisionbehavior.addBoundary(withIdentifier: "Barrier" as NSCopying, for: UIBezierPath(rect: boat.frame))
        collisionbehavior.collisionDelegate = self
        screenwidth = screensize.width
        
        let path = Bundle.main.path(forResource: "music1.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        //let durationCheck = 20 * timesReplayed
        do{
            self.backgroundmusic = try AVAudioPlayer(contentsOf: url)
            self.backgroundmusic?.play()
            //backgroundmusic?.currentTime = TimeInterval(durationCheck >= 399 ? 0 : 20 * timesReplayed)
        }catch{
            //couldn't load file :(
        }
        
        var riverimages: ([UIImage])!
        self.background.backgroundColor = UIColor.blue
        self.background.isHidden = true
        self.gameover.isHidden = true
        self.boat.isHidden = false
        self.view.bringSubview(toFront: self.boat)
        self.replaybutton.isHidden = true
        self.scoretitle.isHidden = false
        self.finalscore.isHidden = true
        
        
        gravitybehavior = UIGravityBehavior()
        dynamicItemBehavior = UIDynamicItemBehavior()
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        riverimages = [UIImage(named: "river1.jpg")!,
                       UIImage(named: "river2.jpg")!,
                       UIImage(named: "river3.jpg")!,
                       UIImage(named: "river4.jpg")!,
                       UIImage(named: "river5.jpg")!,
                       UIImage(named: "river6.jpg")!,
                       UIImage(named: "river7.jpg")!,
                       UIImage(named: "river8.jpg")!,
                       UIImage(named: "river9.jpg")!,
                       UIImage(named: "river10.jpg")!,
                       UIImage(named: "river11.jpg")!,
                       UIImage(named: "river12.jpg")!,
                       UIImage(named: "river13.jpg")!,
                       UIImage(named: "river14.jpg")!,
                       UIImage(named: "river15.jpg")!,
                       UIImage(named: "river16.jpg")!,
                       UIImage(named: "river17.jpg")!,
                       UIImage(named: "river18.jpg")!,
                       UIImage(named: "river19.jpg")!,
                       UIImage(named: "river20.jpg")!,]
        
        riverarray.image = UIImage.animatedImage(with: riverimages, duration: 2)
        
        let start = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: start){
            
            let delay = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.buoyspawn), userInfo: nil, repeats: true)
            
            let finish = DispatchTime.now() + 20
            DispatchQueue.main.asyncAfter(deadline: finish){
                self.background.isHidden = false
                self.boat.isHidden = true
                self.gameover.isHidden = false
                self.scoretitle.isHidden = true
                self.finalscore.isHidden = false
                self.replaybutton.isHidden = false
                 
                self.backgroundmusic?.stop()
                self.view.bringSubview(toFront: self.background)
                self.view.bringSubview(toFront: self.gameover)
                self.view.bringSubview(toFront: self.replaybutton)
                self.view.bringSubview(toFront: self.finalscore)
                
                if(self.scorenumber < 0){
                    let path = Bundle.main.path(forResource: "SadTrombone .mp3", ofType: nil)!
                    let url = URL(fileURLWithPath: path)
                    //let durationCheck = 20 * timesReplayed
                    do{
                        self.gameovermusic = try AVAudioPlayer(contentsOf: url)
                        self.gameovermusic?.play()
                        
                    }catch{
                        //couldn't load file :(
                    }
                }
                
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
    
    func buoyspawn(){
        if (count < 20){
            var buoyarray = ["buoy.gif", "buoy2.gif", "buoy3.gif", "buoy4.gif"]
            let randombuoy = Int(arc4random_uniform(UInt32(3))) + 1
            var shufflebuoy = [String]()
            
            
            for i in 1...randombuoy {
                let randbuoy = Int(arc4random_uniform(UInt32(buoyarray.count)))
                shufflebuoy.append(buoyarray[randbuoy])
                buoyarray.remove(at: randbuoy)
            }
            
            for index in 1...randombuoy{
                
                let lower: UInt32 = UInt32(screenwidth! * 0.20)
                let upper: UInt32 = UInt32(screenwidth! * 0.70)
                let randomx = Int(arc4random_uniform(UInt32(upper - lower))) + Int(lower)
                
                let buoyimage = UIImage(named: shufflebuoy[index - 1])
                let buoyimageview = UIImageView(image: buoyimage)
                buoyimageview.frame = CGRect(x: randomx, y: 0, width: 29, height: 51)
                self.view.addSubview(buoyimageview)
                obstacle.append(buoyimageview)
                
                //dynamicItemBehavior.addItem(buoyimageview)
                //self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: 0, y: 300), for: buoyimageview)
                //dynamicAnimator.addBehavior(dynamicItemBehavior)
                
                gravitybehavior.addItem(buoyimageview)
                gravitybehavior = UIGravityBehavior(items: [buoyimageview])
                gravitybehavior.gravityDirection = CGVector(dx: 0.0, dy: 0.3)
                dynamicAnimator.addBehavior(gravitybehavior)
                
                collisionbehavior.addItem(buoyimageview)
                dynamicAnimator.addBehavior(collisionbehavior)
            }
            scorenumber = scorenumber + Int(shufflebuoy.count * 5);
            score.text = String(scorenumber)
            finalscore.text = (score.text! + " Points")
            
            print(count)
            print("Total Buoys: ", randombuoy)
            print("Score result: ", scorenumber)
            count = count + 1
        
        }
    }
    func changesomething() {
        collisionbehavior.removeAllBoundaries()
        collisionbehavior.addBoundary(withIdentifier: "Barrier" as NSCopying, for: UIBezierPath(rect: boat.frame))
    }

}

