//
//  LogInView.swift
//  App
//
//  Created by Raul Quispe on 8/6/18.
//  Copyright © 2018 QuimaDevelopers. All rights reserved.
//

import UIKit

class LogInView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addValues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     TODO: This funciont add values and styles to graphics UI Elements
    */
    func addValues() {
        
        self.txtfPassword.font = UIFont(name: "Helvetica", size: 15)
        self.txtfPassword.textColor = UIColor.cyan
        
        self.btnEnter.layer.cornerRadius = 5
        self.btnEnter.layer.borderWidth = 1
        self.btnEnter.layer.borderColor = UIColor.black.cgColor
        
    }
    // MARK: - UI Elements
  
    @IBOutlet weak var txtfUsername: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    
    @IBOutlet weak var btnEnter: UIButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
