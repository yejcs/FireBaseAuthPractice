//
//  MainViewController.swift
//  FirebaseAuthPractice2
//
//  Created by Yejin on 2022/10/25.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLb: UILabel!
    @IBOutlet weak var resetPwdBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLb.text = """
            환영합니다
            \(email)님
            """
        
        let isEmailSingedIn = Auth.auth().currentUser?.providerData[0].providerID == "password" //현재 아이디가 이메일/비번으로 로그인 했냐
        resetPwdBtn.isHidden = !isEmailSingedIn
    }
 
    @IBAction func logoutBtnTap(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError{
            print("error: signout \(signOutError.localizedDescription)")
        }
        
    }
    
    @IBAction func resetPwdBtnTapped(_ sender: Any) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)//현재 로그인된 메일주소로 비밀번호 변경 메일 전송
    }
}
