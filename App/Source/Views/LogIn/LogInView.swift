//
//  LogInView.swift
//  App
//
//  Created by Raul Quispe on 8/6/18.
//  Copyright © 2018 QuimaDevelopers. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class LogInView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addValues()
        self.binding()
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
    let disposeBag = DisposeBag()
    func binding() {
        txtfUsername.rx.text.asDriver().drive(txtfPassword.rx.text)
            .disposed(by: disposeBag)
    }
  
    // MARK: - UI Elements
  
    @IBOutlet weak var txtfUsername: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    
    @IBOutlet weak var btnEnter: UIButton!

    @IBAction func getProfile(_ sender: Any) {
        let username = "aquima"
        let password = "olokb7i88"
        let loginString = String(format: "%@:%@", username, password)
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

            }
            
        })
        task.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
