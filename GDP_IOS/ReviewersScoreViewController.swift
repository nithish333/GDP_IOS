//
//  ReviewersScoreViewController.swift
//  GDP_IOS
//
//  Created by Chilakapati,Lakshmi Kalyani on 5/25/23.
//

import UIKit

class ReviewersScoreViewController: UIViewController {
    var re : Review = Review(approve: "", email: "", findings: "", objective: "", presentation: "", relevance: "", theoretical: "");
    var total = 0
    @IBOutlet weak var tot: UILabel!
    @IBOutlet weak var t: UILabel!
    @IBOutlet weak var r: UILabel!
    @IBOutlet weak var p: UILabel!
    @IBOutlet weak var o: UILabel!
    @IBOutlet weak var f: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(re)
        f.text! += re.findings
        t.text! += re.theoretical
        o.text! += re.objective
        p.text! += re.presentation
        r.text! += re.relevance
        tot.text! += String(total)
        // Do any additional setup after loading the view.
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
