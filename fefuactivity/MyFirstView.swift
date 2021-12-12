//
//  MyFirstView.swift
//  fefuactivity
//
//  Created by wsr1 on 12.12.2021.
//

import UIKit

class MyFirstView: UIViewController {

    
    @IBOutlet weak var conn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        conn.text = "aboba"
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
