//
//  AuthorDashboardViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/16/23.
//

import UIKit
import SwiftyJSON
class AuthorDashboardViewController: UIViewController {
    var userValue : Any?;
   
    
    @IBOutlet weak var areasOutlet: UILabel!
    @IBOutlet weak var emailOutlet: UILabel!
    
    @IBOutlet weak var nameOutlet: UILabel!
    
    var email = "";
    var firstName = "";
    var lastName = "";
    var paperTitle = "";
    var approved = "";
    var areas = "";
    var id = "";
    var url = "";
    var review : [Review] = []
    var reviewerPoints : [Int] = []
    var reviewerApproval : [String] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailOutlet.text = "Email : \(email)"
        nameOutlet.text = "Name : \(firstName) \(lastName)"
        areasOutlet.text = "Areas of ineterest : \(areas)"
        
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func onPaperStatusClicked(_ sender: Any) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var trans = segue.identifier;
        if(trans == "paperStatusSegue")
        {
            var des = segue.destination as! PaperStatusViewController;
            des.paperTitle = paperTitle;
            des.approved = approved;
            des.reviewerApproval = reviewerApproval
            des.id = id;
            des.url = url;
            des.review = review
            des.reviewerPoints = reviewerPoints
        }
    }
}
