//
//  StudentDashboardViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/24/23.
//

import UIKit

class StudentDashboardViewController: UIViewController {
    
    var email = "";
    var firstName = "";
    var lastName = "";
    var paperTitle = "";
    var approved = "";
    var areas = "";
    var id = "";
    var url = "";
    var reviewerApproval : [Any] = []
    
    @IBOutlet weak var areasOutlet: UILabel!
    @IBOutlet weak var emailOutlet: UILabel!
    @IBOutlet weak var nameOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        for re in reviewerApproval{
            print("Reviewer")
        }
        emailOutlet.text = "Email : \(email)"
        nameOutlet.text = "Name : \(firstName) \(lastName)"
        areasOutlet.text = "Areas of ineterest : \(areas)"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onPaperStatusCLicked(_ sender: Any) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var trans = segue.identifier;
        if(trans == "studentPaperStatusSegue")
        {
            var des = segue.destination as! PaperStatusViewController;
            des.paperTitle = paperTitle;
            des.approved = approved;
            des.id = id;
            des.url = url;
        }


}
}
