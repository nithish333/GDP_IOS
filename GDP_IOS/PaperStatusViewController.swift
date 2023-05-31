//
//  PaperStatusViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/23/23.
//

import UIKit

class PaperStatusViewController: UIViewController {
    @IBOutlet weak var paperTitleOutlet: UILabel!
    
    var paperTitle = "";
    var approved = "";
    var reviewerApproval : [String] = [];
    var id = "";
    var url = "";
    var reviewerPoints : [Int] = []
    var review : [Review] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        paperTitleOutlet.text = paperTitle
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var trans = segue.identifier;
        print(paperTitle)
        if(trans == "viewStatusSegue")
        {
            var des = segue.destination as! ViewStatusViewController;
            des.paperTitle = paperTitle;
            des.approved = approved;
            des.reviewerApproval = reviewerApproval
            des.id = id;
            des.url = url;
            des.review = review
            des.reviewerPoints = reviewerPoints
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
