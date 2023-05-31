//
//  LoginViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/16/23.
//

import UIKit
import SwiftyJSON
import Firebase
import FirebaseFirestore

struct Review {
    let approve: String
    let email: String
    let findings: String
    let objective:String
    let presentation:String
    let relevance:String
    let theoretical:String
}

struct ReviewItem {
    let comments: String
    let points: Int
}

class LoginViewController: UIViewController {
    
    var email = "";
    var oemail = "";
    var firstName = "";
    var lastName = " ";
    var paperTitle = " ";
    var approved = " ";
    var oapproved = ""
    var areas = "";
    var url = "";
    var reviewerApproval : [String] = [];
    var userData : [String : Any] = [:]
    var paperId = "";
    var reviewArray = [Review]()
    var reviewerPoints : [Int] = []
    var review :[Review] = []
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup safter loading the view.s
        
    }
    

    @IBAction func onLoginClicked(_ sender: Any) {
       
         if(!isValidEmail(self.emailOutlet.text!)) {
            showAlert(message: "Please enter valid email")
        }else{
            let db = Firestore.firestore()
            
                db.collection("user")
                .whereField("email", isEqualTo: emailOutlet.text!)
                .whereField("password", isEqualTo: passwordOutlet.text!)
                .getDocuments { [self] (querySnapshot, error) in
                            if let error = error {
                                self.showAlert(message:"Error getting user data: \(error)")
                                return
                            }
                            
                            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                                self.showAlert(message:"User not found")
                                return
                            }
                            
                             userData = documents[0].data()
                    oemail = userData["email"] as! String;
                    firstName = userData["firstName"] as! String;
                    lastName = userData["lastName"] as! String;
                    paperTitle = userData["title"] as! String;
                    oapproved = userData["approved"] as! String;
                    areas = userData["areaOfInterest"] as! String;
                    paperId = userData["paperID"] as! String;
                    url = userData["document"] as! String;
                    var r = userData["reviewerApproval"]
//                   print(r)
                    if let dataArray = r as? [[String: Any]] {
                        for dataDict in dataArray {
                            // Access individual dictionary elements
                            approved = (dataDict["approve"] as? String)!

                            email = (dataDict["email"] as? String)!
                            
                            var findings = dataDict["findings"] as? [String: Any]
                            var objective = dataDict["objective"] as? [String: Any]
                            var relavance = dataDict["relavance"] as? [String: Any]
                            var presentation = dataDict["presentation"] as? [String: Any]
                            var theoretical = dataDict["theoretical"] as? [String: Any]
                            var comments = findings?["comments"] as? String
                            var fpoints: String = findings?["points"] as? String ?? "0"
                            var opoints: String = objective?["points"] as? String ?? "0"
                            var rpoints: String = relavance?["points"] as? String ?? "0"
                            var ppoints: String = presentation?["points"] as? String ?? "0"
                            var tpoints: String = theoretical?["points"] as? String ?? "0"
                            var rev = Review(approve: approved, email: email, findings: fpoints, objective: opoints, presentation: ppoints, relevance: rpoints, theoretical: tpoints)
                            review.append(rev)
                            if let fpointsInt = Int(fpoints),
                               let opointsInt = Int(opoints),
                               let rpointsInt = Int(rpoints),
                               let ppointsInt = Int(ppoints),
                               let tpointsInt = Int(tpoints) {
                                let score = fpointsInt + opointsInt + rpointsInt + ppointsInt + tpointsInt
                                
                                reviewerPoints.append(score)
                                print(userData)
                            }
                           print(approved)
                            
                            // Access other dictionary elements in a similar way
                            
                            print("-------------------------")
                        }
                    } else {
                        print("Unable to convert the data into an array of dictionaries")
                    }

                    // Now you have an array of Review objects representing the data from the dictionaries

//                    var r = userData["reviewerApproval"]
                   print("Reviewer array: \(reviewArray)")
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    func showAlert(message:String){
        
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)

        // Create the action for the alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        // Add the action to the alert
        alertController.addAction(okAction)

        // Present the alert
        self.present(alertController, animated: true, completion: nil)
    }
    func autoCloseAlert(){
        let alertController = UIAlertController(title: "Alert", message: "Loading....", preferredStyle: .alert)
                present(alertController, animated: true, completion: nil)

        let duration = 2.0 // Duration in seconds
                Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
                    alertController.dismiss(animated: true, completion: nil)
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let transition = segue.identifier;
        
        if(transition == "authorLoginSegue"){
            
            let des = segue.destination as! AuthorDashboardViewController;
            if(email.isEmpty){
            autoCloseAlert()

            }
            
            des.email = oemail;
            des.firstName = firstName
                des.lastName = lastName
            des.paperTitle = paperTitle;
            des.approved = oapproved
            des.areas = areas;
            des.reviewerApproval = reviewerApproval
            des.id = paperId;
            des.url = url
            des.review = review
            des.reviewerPoints = reviewerPoints
        }
    }
}

