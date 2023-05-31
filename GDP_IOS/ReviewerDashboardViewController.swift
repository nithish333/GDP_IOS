//
//  ReviewerDashboardViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/23/23.
//

import UIKit
import Firebase
import FirebaseFirestore

class ReviewerDashboardViewController: UIViewController {
    var userValue : Any?;
    var email = "";
    var firstName = "";
    var lastName = "";
    var areas = "";
    var id = "";
    
    var titles :[String] = [];
    @IBOutlet weak var areasOutlet: UILabel!
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var emailOutlet: UILabel!
    var userData = [[String : Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailOutlet.text = "Email : \(email)"
        nameOutlet.text = "Name : \(firstName) \(lastName)"
        areasOutlet.text = "Areas of ineterest : \(areas)"
        let db = Firestore.firestore()
        db.collection("user").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                for document in documents {
                    let data = document.data()
                    
                    if let reviewers = data["reviewers"] as? [[String: Any]] {
                        for reviewer in reviewers {
                            if let remail = reviewer["email"] as? String, remail == self.email {
                                if let title = data["title"] as? String {
                                    self.titles.append(title)
                                    // Perform further actions if needed
                                }
                                
                                    self.userData.append(data)
                                break
                            }
                        }
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trans = segue.identifier
        if(trans == "npSegue"){
            let des = segue.destination as! NewPapersViewController
            des.paperTitles = titles
            des.userdata = userData
        }
    }

}
