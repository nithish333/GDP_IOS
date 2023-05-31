//
//  ViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/16/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    var menuout = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func menuTapped(_ sender: Any) {
        if(menuout==false){
            leading.constant = -200;
            trailing.constant = 200;
            menuout = true;
            
        }else{
            leading.constant = 0;
            trailing.constant = 0;
            menuout = false;
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) {(animationComplete) in print("Animation completed")}
    }
    
}

