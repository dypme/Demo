//
//  ViewController.swift
//  Demo
//
//  Created by MBP2022_1 on 11/10/22.
//

import UIKit
import Covantex_SDK

class ViewController: UIViewController {
    
    @IBOutlet weak var emailFld: UITextField!
    @IBOutlet weak var passwordFld: UITextField!
    @IBOutlet weak var loginMsgLbl: UILabel!
    
    @IBOutlet weak var mhdValMsgLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let apiSession = API.shared.getSession()
        self.loginMsgLbl.text = "Token: \(apiSession.authorization)"
    }


    @IBAction func login(_ sender: Any) {
        let email = emailFld.text!
        let password = passwordFld.text!
        
        var signInDto = SignInDto(JSON: [:])!
        signInDto.login = email
        signInDto.password = password
        
        let apiSession = API.shared.getSession()
        apiSession.apiUserRole = ""
        apiSession.authorization = ""
        API.shared.updateSession(session: apiSession)
        
        loginMsgLbl.text = "Loading..."
        API.mainService.signIn(body: signInDto, onSuccess: { responseDto in
            if responseDto.isErrorFound() {
                self.loginMsgLbl.text = "Login Response Error: \(responseDto.getLocalisedErrorMessage())"
                return
            }
            
            let role = responseDto.data?.roles?.first ?? ""
            let authorization = responseDto.data?.token ?? ""
            let userId = responseDto.data?.userId ?? ""
            
            let apiSession = API.shared.getSession()
            apiSession.apiUserRole = role
            apiSession.authorization = authorization
            API.shared.updateSession(session: apiSession)
            self.loginMsgLbl.text = "User ID: \(userId)\nToken: \(authorization)"
        }) { error in
            self.loginMsgLbl.text = "Login Error: \(error.getLocalisedErrorMessage())"
        }
    }
    
    @IBAction func fetchMhdValues(_ sender: Any) {
        mhdValMsgLbl.text = "Loading..."
        API.mainService.getMhdValues { responseDto in
            if responseDto.isErrorFound() {
                self.mhdValMsgLbl.text = "Login Response Error: \(responseDto.getLocalisedErrorMessage())"
                return
            }
            self.mhdValMsgLbl.text = "Mhd Values data:\n\(responseDto.toJSONString(prettyPrint: true) ?? "nil")"
        } onFailure: { error in
            self.mhdValMsgLbl.text = "Login Error: \(error.getLocalisedErrorMessage())"
        }
    }
}

