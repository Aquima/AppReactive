//
//  LogInViewController.swift
//  App
//
//  Created by User on 8/15/18.
//  Copyright © 2018 QuimaDevelopers. All rights reserved.
//

//
//  LogInView.swift
//  App
//
//  Created by Raul Quispe on 8/6/18.
//  Copyright © 2018 QuimaDevelopers. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    private var user:User!
    // MARK: - UI Elements
    @IBOutlet weak var txtfUsername: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var btnEnter: UIButton!
    
    let requiredLength = 5
    
    var isUsernameValid:Bool = false
    var isPasswordValid:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addValues()
        self.user = User()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - UITextFieldDelegate
    @objc func textFieldDidChange(textField: UITextField){
   
        if textField.tag == 0 {
            if textField.text!.count >= self.requiredLength {
                self.isUsernameValid = true
            }else{
                self.isUsernameValid = false
            }
            
        } else if textField.tag == 1 {
            if textField.text!.count >= self.requiredLength {
                self.isPasswordValid = true
            }else{
                self.isPasswordValid = false
            }
        }
        
        if self.isUsernameValid && self.isPasswordValid {
            self.btnEnter.isEnabled = true
        }else{
            self.btnEnter.isEnabled = false
        }
    }
    func addValues() {
        
        self.btnEnter.isEnabled = false
        self.btnEnter.setTitle("", for: .disabled)
        self.btnEnter.setTitle("Ingresar", for: .normal)
        self.txtfPassword.font = UIFont(name: "Helvetica", size: 15)
        self.txtfPassword.textColor = UIColor.purple
        
        self.txtfUsername.tag = 0
        self.txtfPassword.tag = 1

        self.txtfUsername.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.txtfPassword.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
 
    }

    @IBAction func getProfile(_ sender: Any) {
        self.user.username = self.txtfUsername.text!
        self.user.password = self.txtfPassword.text!
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let view:ProfileView = storyboard.instantiateViewController(withIdentifier: "ProfileView") as! ProfileView
        
        
//        self.present(view, animated: true, completion: nil)
        
        let loginString = String(format: "%@:%@", user.name, user.password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        // create the request
        let url = URL(string: "https://api.github.com/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let session: URLSession
        session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options:
                    JSONSerialization.ReadingOptions.mutableContainers)
                print(jsonResult)
                
            } catch let err {
                print(err.localizedDescription)
            }
            
        })
        task.resume()
    }
    
}
