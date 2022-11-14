//
//  EmailViewController.swift
//  FirebaseAuthPractice2
//
//  Created by Yejin on 2022/10/25.
//



import UIKit
import FirebaseAuth

class EmailViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var pwdTxt: UITextField!
    @IBOutlet weak var errorMessageLb: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        emailTxt.delegate = self
        pwdTxt.delegate = self
        
        nextBtn.layer.cornerRadius = 20
        nextBtn.isEnabled = false
        
        emailTxt.becomeFirstResponder() //처음에 커서가 여기에 위치하도록
    }
    
    @IBAction func nextBtnTap(_ sender: Any) {
        let email = emailTxt.text ?? ""
        let password = pwdTxt.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일 때
                    self.loginUser(withEmail: email, password: password)
                default: 
                    self.errorMessageLb.text = error.localizedDescription
                }
            } else {
                
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        //로그인 함수 signIn
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLb.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
    
}

extension EmailViewController: UITextFieldDelegate {
    //edit 끝나면 버튼 눌렀을 때 키보드가 내려가도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    // 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTxt.text == ""
        let isPwdEmpty = pwdTxt.text == ""
        nextBtn.isEnabled = !isEmailEmpty && !isPwdEmpty
    }
    
}

