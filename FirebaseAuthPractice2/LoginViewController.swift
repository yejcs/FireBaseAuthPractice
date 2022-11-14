//
//  LoginViewController.swift
//  FirebaseAuthPractice2
//
//  Created by Yejin on 2022/10/25.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var googleBtn: GIDSignInButton!
    @IBOutlet weak var appleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [emailBtn,googleBtn,appleBtn].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.lightGray.cgColor
            $0?.layer.cornerRadius = 20
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
        //Google Sign In
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    @IBAction func emailBtnTap(_ sender: Any) {
    }
    @IBAction func googleBtnTap(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func appleBtnTap(_ sender: Any) {
    }

}
