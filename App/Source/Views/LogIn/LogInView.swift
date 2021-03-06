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
import RxGesture
/*
 PDT: Raul Quispe
 Contactenme para cualquier duda o crear un canal de comunicacion
 para aprender mas acerca de RxSwift y Programacion Reactiva.
 email: raul.quispe@live.com
 */
class LogInView: UIViewController {
    private var user:User!
    // MARK: - UI Elements
    @IBOutlet weak var txtfUsername: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var btnEnter: UIButton!

    let requiredLength = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addValues()
        self.user = User()
        
        self.view.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                //react to taps
                self.txtfPassword.resignFirstResponder()
                self.txtfUsername.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        let userNameValid: Observable<Bool> = self.txtfUsername.rx.text
            .map{ text -> Bool in
              
                text!.count >= self.requiredLength
            }
            .share(replay: 1)
        let passwordValid: Observable<Bool> = self.txtfPassword.rx.text
            .map{ text -> Bool in
               
                text!.count >= self.requiredLength
            }
            .share(replay:1)
        
        let everythingValid: Observable<Bool>
            = Observable.combineLatest(userNameValid, passwordValid) {
                $0 && $1
                
        }

        everythingValid
            .bind(to: self.btnEnter.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addValues() {
        
        self.btnEnter.setTitle("", for: .disabled)
        self.btnEnter.setTitle("Ingresar", for: .normal)
        self.txtfPassword.font = UIFont(name: "Helvetica", size: 15)
        self.txtfPassword.textColor = UIColor.purple
        
    }
    
    let disposeBag = DisposeBag()

    func binding() {
//        txtfUsername.rx.text.asDriver().drive(self.txtfPassword.rx.text)
//            .disposed(by: disposeBag)
    }

    @IBAction func getProfile(_ sender: Any) {
        self.user.username = self.txtfUsername.text!
        self.user.password = self.txtfPassword.text!
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let view:ProfileView = storyboard.instantiateViewController(withIdentifier: "ProfileView") as! ProfileView
//
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
