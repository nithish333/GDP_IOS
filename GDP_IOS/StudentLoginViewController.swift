//
//  StudentLoginViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/24/23.
//

import UIKit
import Firebase
import FirebaseFirestore

class StudentLoginViewController: UIViewController {
    var email = "";
    var firstName = "";
    var lastName = " ";
    var paperTitle = " ";
    var approved = " ";
    var userData : [String : Any] = [:]
    var areasOfIntrest = "";
    var paperId = ""
    var url = "";
    var reviewerApproval : [Any] = [];
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        if(!isValidEmail(self.emailOutlet.text!)) {
           showAlert(message: "Please enter valid email")
       }else{
           let db = Firestore.firestore()
           
               db.collection("student")
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
                   email = userData["email"] as! String;
                   firstName = userData["firstName"] as! String;
                   lastName = userData["lastName"] as! String;
                   paperTitle = userData["title"] as! String;
                   approved = userData["approved"] as! String;
                   areasOfIntrest = userData["areaOfInterest"] as! String;
                   paperId = userData["paperID"] as! String;
                   url = userData["document"] as! String;
                   reviewerApproval = userData["reviewerApproval"] as! [Any]
                   for re in reviewerApproval{
                       print("Reviewer")
                   }
                   print(userData)
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
        
        if(transition == "studentLoginSegue"){
            
            let des = segue.destination as! StudentDashboardViewController;
            if(email.isEmpty){
            autoCloseAlert()
            }
            des.email = email;
            des.firstName = firstName
            des.lastName = lastName
            des.paperTitle = paperTitle;
            des.approved = approved
            des.areas = areasOfIntrest
            des.id = paperId
            des.url = url;
            des.reviewerApproval = reviewerApproval
        }
    }

}
