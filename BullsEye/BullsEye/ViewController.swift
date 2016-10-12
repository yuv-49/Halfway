//
//  ViewController.swift
//  BullsEye
//
//  Created by yuvraj singh on 09/10/16.
//  Copyright © 2016 yuvraj singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var currentPosition: Int = 50
  var targetValue: Int = 0
  var score = 0
  var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewround()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBOutlet weak var slider: UISlider!
    @IBAction func showAlert(_ sender: AnyObject) {
      let difference = abs(targetValue - currentPosition)
      var points = 100 - difference
      score += points
      
      var title = "Perfect"
      if (difference == 0) {
        title = "Perfect"
        points += 100
        score += 100
      }
      else if(difference < 5){
        title = "pretty close"
      }
      else if(difference < 10){
        title = "quite close"
      }
      else{
        title = "screwed"
      }
      let message = "you scored \(points) points"
      
      /*
        let message = "the value of slider is: \(currentPosition)"
                        + "\nthe target value is: \(targetValue)"
      */
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome",
                                   style: .destructive,
                                   handler: {action in
                                            self.startNewround()
                                            self.updateLabels()
                                    }) //quite important.
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
      
    }
    @IBAction func sliderMoved(slider: UISlider) {
        print("the value of sliser is now \(slider.value)")
        currentPosition = lroundf(slider.value)
    }
  func startNewround(){
    round += 1
    targetValue = 1 + Int(arc4random_uniform(100))
    currentPosition = 50
    slider.value = Float(currentPosition)
  }
  
  
  
  
  func updateLabels(){
    targetLabel.text = String(targetValue)
    scoreLabel.text = "\(score)"
    roundLabel.text = "\(round)"
    
  }
  
  @IBOutlet weak var scoreLabel: UILabel!
  
  
  
  @IBAction func startOver() {
    score = 0
    round = 0
    startNewround()
  }
  
  

  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var targetLabel: UILabel!
}


