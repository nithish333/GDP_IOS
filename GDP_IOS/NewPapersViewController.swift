//
//  NewPapersViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/31/23.
//

import UIKit

class NewPapersViewController: UIViewController {
    
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var p3: UILabel!
    @IBOutlet weak var p2: UILabel!
    @IBOutlet weak var p1: UILabel!
    @IBOutlet weak var a3: UILabel!
    @IBOutlet weak var a2: UILabel!
    @IBOutlet weak var a1: UILabel!
    let index1 = 0
    let index2 = 1
    let index3 = 2
    var userdata  = [[String : Any]]()
    var paperTitles : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if index1 < paperTitles.count {
            if let content = paperTitles[0] as? String, !content.isEmpty {
                p1.text! = paperTitles[0]
            } else {
                p1.text! = "Not yet assigned"
                b1.isEnabled = false
            }
        } else {
            p1.text! = "Not yet assigned"
            b1.isEnabled = false
        }
        if index2 < paperTitles.count {
            if let content = paperTitles[1] as? String, !content.isEmpty {
                p2.text! = paperTitles[1]
            } else {
                p2.text! = "Not yet assigned"
                b2.isEnabled = false
            }
        } else {
            p1.text! = "Not yet assigned"
            b2.isEnabled = false
        }
        if index3 < paperTitles.count {
            if let content = paperTitles[2] as? String, !content.isEmpty {
                p3.text! = paperTitles[2]
            } else {
                p3.text! = "Not yet assigned"
                b3.isEnabled = false
            }
        } else {
            p3.text! = "Not yet assigned"
            b3.isEnabled = false
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trans = segue.identifier
        if(trans == "d1Seg"){
            let des = segue.destination as! PaperDetailsViewController
            des.userData = userdata[0]
        }
        if(trans == "d2Seg"){
            let des = segue.destination as! PaperDetailsViewController
            des.userData = userdata[1]
        }
        if(trans == "d3Seg"){
            let des = segue.destination as! PaperDetailsViewController
            des.userData = userdata[2]
        }
    }
}


