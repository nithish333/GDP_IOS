//
//  PaperDetailsViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/31/23.
//

import UIKit

class PaperDetailsViewController: UIViewController {
    var userData = [String : Any]()
    
    @IBOutlet weak var plink: UILabel!
    @IBOutlet weak var kw: UILabel!
    @IBOutlet weak var nam: UILabel!
    @IBOutlet weak var tit: UILabel!
    @IBOutlet weak var id: UILabel!
    var firstName = ""
    var lastName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userData)
        id.text! += userData["paperID"] as! String
        tit.text = userData["title"] as! String
        firstName = userData["firstName"] as! String
        lastName = userData["lastName"] as! String
        nam.text! += "\(firstName) \(lastName)"
        kw.text! += userData["otherKeyword"] as! String
        let linkText = userData["document"] as! String
              
              // Create an attributed string with a link attribute
              let attributedString = NSMutableAttributedString(string: linkText)
              let range = NSRange(location: 0, length: linkText.count)
              attributedString.addAttribute(.link, value: userData["document"] as! String, range: range)
              
              // Set the attributed text to the label
              plink.attributedText = attributedString
              
              // Enable interaction and set the label's data detector types
              plink.isUserInteractionEnabled = true
        plink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLinkTap(_:))))
          
              // Add a tap gesture recognizer to handle link taps
              let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLinkTap(_:)))
              plink.addGestureRecognizer(tapGesture)
          }
          
          @objc func handleLinkTap(_ gesture: UITapGestureRecognizer) {
              guard let label = gesture.view as? UILabel else {
                  return
              }
              
              if let url = label.attributedText?.attribute(.link, at: 0, effectiveRange: nil) as? URL {
                  UIApplication.shared.open(url)
              }       }
    }
        // Do any additional setup after loading the view.
    


