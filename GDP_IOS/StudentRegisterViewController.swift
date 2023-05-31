//
//  StudentRegisterViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/24/23.
//

import UIKit
import Firebase
import FirebaseFirestore

class StudentRegisterViewController: UIViewController {

    @IBOutlet weak var areasOutlet: UITextField!
    @IBOutlet weak var lastNameOutlet: UITextField!
    @IBOutlet weak var firstNameOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onStudentRegisterClicked(_ sender: Any) {
        if(self.passwordOutlet.text!.count < 7) {
            print("inside this loop")
             showAlert(message: "Please enter password greater than 7")
        }else if(!isValidEmail(self.emailOutlet.text!)) {
            showAlert(message: "Please enter valid email")
        }else{
            let db = Firestore.firestore()

                   // Create a user document in Firestore with the custom login data
            let userData = ["email": emailOutlet.text!, "password": passwordOutlet.text!,"firstName":firstNameOutlet.text!,"lastName":lastNameOutlet.text!,"areaOfInterest":areasOutlet.text!]
                   db.collection("reviewer").addDocument(data: userData) { error in
                       if let error = error {
                           print("Error writing user data: \(error)")
                           // Handle the error condition
                       } else {
                           print("User data written successfully!")
                           // Perform any necessary actions after successful login
                       }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var trans = segue.identifier
        if(trans == "studentRegisterSegue"){
            let des = segue.destination as! StudentDashboardViewController;
            des.email = emailOutlet.text!;
            des.firstName = firstNameOutlet.text!
            des.lastName = lastNameOutlet.text!
        }
    }

}
