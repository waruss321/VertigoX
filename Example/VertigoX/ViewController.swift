//
//  ViewController.swift
//  VertigoX
//
//  Created by waruss321 on 12/15/2019.
//  Copyright (c) 2019 waruss321. All rights reserved.
//

import UIKit
import VertigoX

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let testvc = TestVC()
        
        testvc.fireme.subscribe(with: self) { _ in
            print("Firing")
        }
        
        
        self.present(testvc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



