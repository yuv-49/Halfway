//
//  ViewController.swift
//  new8
//
//  Created by yuvraj singh on 16/09/16.
//  Copyright © 2016 Pluto Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var viewItem: UIView!
    var effect:UIVisualEffect!
    override func viewDidLoad() {
        super.viewDidLoad()
        effect = visualEffect.effect
        visualEffect.effect = nil
        viewItem.layer.cornerRadius = 5
        
        
        
    }
    
    func animatein() {
        self.view.addSubview(viewItem)
        viewItem.center = self.view.center
        viewItem.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        viewItem.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.visualEffect.effect = self.effect
            self.viewItem.alpha = 1
            self.viewItem.transform = CGAffineTransform.identity
            
        }
        
        func animateout(){
            UIView.animate(withDuration: 0.3,animations: {
                            self.viewItem.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                           self.viewItem.alpha = 0
                            self.visualEffect.effect = nil
            }) { (success:Bool) in
                self.viewItem.removeFromSuperview()
            
        }
    }

    @IBAction func addBtn(_ sender: AnyObject) {
        animatein()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismissPopup(_ sender: AnyObject) {
        animateout()
    }

}

