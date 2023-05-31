//
//  ViewStatusViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/23/23.
//

import UIKit

class ViewStatusViewController: UIViewController {
    @IBOutlet weak var paperTitleOutlet: UILabel!
    
    @IBOutlet weak var re3B: UIButton!
    @IBOutlet weak var re2B: UIButton!
    @IBOutlet weak var re1B: UIButton!
    @IBOutlet weak var re3A: UILabel!
    @IBOutlet weak var re3S: UILabel!
    @IBOutlet weak var re2A: UILabel!
    @IBOutlet weak var re2S: UILabel!
    @IBOutlet weak var re1Approve: UILabel!
    @IBOutlet weak var re1Score: UILabel!
    var paperTitle = "";
    @IBOutlet weak var idOutlet: UILabel!
    var approved = "";
    var reviewerApproval : [String] = [];
    var id = "";
    var url = ""
    var reviewerPoints : [Int] = []
    var review : [Review] = []
    @IBOutlet weak var statusOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(reviewerPoints[0])
        let index1 = 0 // Specify the index for textOutlet1
        let index2 = 1 // Specify the index for textOutlet2
        let index3 = 2 // Specify the index for textOutlet3

        // Check for textOutlet1
        if index1 < reviewerPoints.count {
            if let content = reviewerPoints[0] as? Int{
                re1Score.text! += String(reviewerPoints[0])
            } else {
                re1Score.text! += "Pending"
                re1B.isEnabled = false
            }
        } else {
            re1Score.text! += "Pending"
            re1B.isEnabled = false
        }

        // Check for textOutlet2
        if index2 < reviewerPoints.count {
            if let content = reviewerPoints[1] as? Int{
                re2S.text! += String(reviewerPoints[1])
            } else {
                re2S.text! += "Pending"
                re2B.isEnabled = false
            }
        } else {
            re2S.text! += "Pending"
            re2B.isEnabled = false
        }

        // Check for textOutlet3
        if index3 < reviewerPoints.count {
            if let content = reviewerPoints[2] as? Int {
                re3S.text! += String(reviewerPoints[2])
            } else {
                re3S.text! += "Pending"
                re3B.isEnabled = false
            }
        } else {
            re3S.text! += "Pending"
            re3B.isEnabled = false
        }
        
        if index1 < review.count {
            if let content = review[0].approve as? String, !content.isEmpty {
                re1Approve.text! += review[0].approve
            } else {
                re1Approve.text! += "Pending"
            }
        } else {
            re1Approve.text! += "Pending"
        }

        // Check for textOutlet2
        if index2 < review.count {
            if let content = review[1].approve as? String, !content.isEmpty {
                re2A.text! += review[1].approve
            } else {
                re2A.text! += "Pending"
            }
        } else {
            re2A.text! += "Pending"
        }

        // Check for textOutlet3
        if index3 < review.count {
            if let content = review[2].approve as? String, !content.isEmpty {
                re3A.text! += review[2].approve
            } else {
                re3A.text! += "Pending"
            }
        } else {
            re3A.text! += "Pending"
        }

        paperTitleOutlet.text = paperTitle;
        statusOutlet.text = "Status : \(approved)"
        idOutlet.text = "Paper ID : \(id)"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onDownloadClicked(_ sender: Any) {
        downloadFile()
    }
    
    func downloadFile() {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        let downloadTask = URLSession.shared.downloadTask(with: url) { (location, response, error) in
            guard let location = location else {
                print("Download failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let fileManager = FileManager.default
            let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsDirectoryURL.appendingPathComponent("file.pdf")

            if fileManager.fileExists(atPath: destinationURL.path) {
                do {
                    try fileManager.removeItem(at: destinationURL)
                    print("Existing file removed")
                } catch {
                    print("Failed to remove existing file: \(error.localizedDescription)")
                }
            }

            do {
                try fileManager.moveItem(at: location, to: destinationURL)
                print("File downloaded successfully. Destination URL: \(destinationURL)")
            } catch {
                print("Failed to move downloaded file: \(error.localizedDescription)")
            }
        }

        downloadTask.resume()
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
        let transition = segue.identifier;
        
        if(transition == "re1Seg"){
            let des = segue.destination as! ReviewersScoreViewController
            des.re = review[0]
            des.total = reviewerPoints[0]
        }
        if(transition == "re2Seg"){
            let des = segue.destination as! ReviewersScoreViewController
            des.re = review[1]
            des.total = reviewerPoints[1]
        }
        if(transition == "re3Seg"){
            let des = segue.destination as! ReviewersScoreViewController
            des.re = review[2]
            des.total = reviewerPoints[2]
        }
    }
}
