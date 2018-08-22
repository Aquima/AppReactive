//
//  ViewController.swift
//  App
//
//  Created by Raul Quispe on 8/6/18.
//  Copyright © 2018 QuimaDevelopers. All rights reserved.
//

import UIKit
import RxSwift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view, typically from a nib.
                let one = 1
                let two = 2
                let three = 3
        
                let observableSequence:Observable<Int> = Observable<Int>.just(one)
                    let observable2 = Observable.of(one,two,three)
                    observable2.subscribe { event in
                        if let element = event.element {
                            print(element)
                        }
        
                    }

                let sequence = 0..<3
    
                var iterator = sequence.makeIterator()
    
                while let n = iterator.next() {
                    print(n)
                }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

