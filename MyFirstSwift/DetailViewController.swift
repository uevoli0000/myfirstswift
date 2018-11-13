//
//  DetailViewController.swift
//  MyFirstSwift
//
//  Created by 이연석 on 2018. 11. 13..
//  Copyright © 2018년 이연석. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func cancelAction(_ sender: UIButton) {
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
    }
}
