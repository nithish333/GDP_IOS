//
//  ReviewerLoginViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/18/23.
//

import UIKit
import Firebase
import FirebaseFirestore

class ReviewerLoginViewController: UIViewController {

    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    
    var email = "";
    var firstName = "";
    var lastName = " ";
    var areas = "";
    var paperId = "";
    var userData : [String : Any] = [:]
    var papers : [String] = []
    var pAssign = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onReviewerLoginClicked(_ sender: Any) {
        print(emailOutlet.text!)
        print(passwordOutlet.text!)
            let db = Firestore.firestore()
            
                db.collection("reviewer")   
                .whereField("email", isEqualTo: passwordOutlet.text!)
                .whereField("password", isEqualTo: emailOutlet.text!)
                .getDocuments { [self] (querySnapshot, error) in
                            if let error = error {
                                showAlert(message:"Error getting user data: \(error)")
                                return
                            }
                            
                            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                                showAlert(message:"User not found")
                                return
                            }
//                    db.collection("user").getDocuments { (querySnapshot, error) in
//                        if let error = error {
//                            print("Error getting documents: \(error)")
//                        } else {
//                            guard let documents = querySnapshot?.documents else {
//                                print("No documents found")
//                                return
//                            }
//
//                            for document in documents {
//                                let data = document.data()
//                                if let reviewers = data["reviewers"] as? [[String: Any]] {
//                                    for reviewer in reviewers {
//                                        if let email = reviewer["email"] as? String, email == email {
//                                            print("Email found in the reviewers array")
//                                            // Perform further actions if needed
//                                            return
//                                        }
//                                    }
//                                }
//                            }
//
//                            print("Email not found in the reviewers array")
//                        }
//                    }
                             userData = documents[0].data()
                    email = userData["email"] as! String;
                    firstName = userData["firstName"] as! String;
                    lastName = userData["lastName"] as! String;
                    areas = userData["areaOfInterest"] as! String;
                    
//                    print(userData)
        
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
            
            if(transition == "reviewLoginSegue"){
                
                let des = segue.destination as! ReviewerDashboardViewController;
                if(email.isEmpty){
                autoCloseAlert()

                }
                
                des.email = email;
                des.firstName = firstName
                    des.lastName = lastName
                des.areas = areas
                des.id = paperId;
            }
        }
    
}


