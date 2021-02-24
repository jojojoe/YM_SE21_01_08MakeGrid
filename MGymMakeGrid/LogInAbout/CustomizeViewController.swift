//
//  CustomizeViewController.swift
//  CustomGramSpacer
//
//  Created by 薛忱 on 2021/2/5.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import Firebase
import AuthenticationServices

class CustomizeViewController: FUIAuthPickerViewController, FUIAuthDelegate {
    
    let ppUrl = "http://late-language.surge.sh/Privacy_Agreement.htm"
    let touUrl = "http://late-language.surge.sh/Terms_of_use.htm"
    
    let def_fontName = ""
    
    override init(nibName: String?, bundle: Bundle?, authUI: FUIAuth) {
        super.init(nibName: "FUIAuthPickerViewController", bundle: bundle, authUI: authUI)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.findButtons(subView: self.view)
        
        let appleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
        appleButton.addTarget(self, action: #selector(appleButtonClick(button:)), for: .touchUpInside)
        self.view.addSubview(appleButton)
        appleButton.snp.makeConstraints { (make) in
            make.width.equalTo(280)
            make.height.equalTo(48)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-170)
        }
        
        let googleButton = buttons[0]
        googleButton.layer.cornerRadius = 8
        googleButton.layer.masksToBounds = true
        googleButton.setTitle(" Sign in with Google", for: .normal)
        googleButton.setTitleColor(.black, for: .normal)
        googleButton.titleLabel?.font = customFont(fontName: "SF-Pro-Text-Medium.otf", size: 18)
        googleButton.frame = CGRect.zero
        googleButton.backgroundColor = .white
        googleButton.contentHorizontalAlignment = .center
        self.view.addSubview(googleButton)
        googleButton.snp.makeConstraints { (make) in
            make.width.equalTo(280)
            make.height.equalTo(48)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-106)
        }

        // Do any additional setup after loading the view.
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(bgImageView, at: 0)
        bgImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(0)
        }
        
        let topView = UIView()
        topView.backgroundColor = UIColor.clear
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(44)
        }
        
        let closebutton = UIButton()
        closebutton.alpha = 0.5
        closebutton.setImage(UIImage(named: "photo_close_ic_x"), for: .normal)
        closebutton.addTarget(self, action: #selector(closebuttonClick(button:)), for: .touchUpInside)
        topView.addSubview(closebutton)
        closebutton.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
         
        let contentBgView = UIView()
        contentBgView.backgroundColor = .clear
        view.addSubview(contentBgView)
        contentBgView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topView.snp.bottom)
            $0.bottom.equalToSuperview().offset(-260)
        }
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "grid_icon_title")
        contentBgView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(276/2)
            make.height.equalTo(212/2)
            make.center.equalToSuperview()
        }
        
    
        let bottomView = UIView()
        bottomView.backgroundColor = .clear
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.bottom.equalTo(-20)
            make.centerX.equalTo(self.view)
        }
        
        let ppButton = UIButton()
        let str = NSMutableAttributedString(string: "Privacy Policy &")
        let strRange = NSRange.init(location: 0, length: str.length)
        //此处必须转为NSNumber格式传给value，不然会报错
        let number = NSNumber(integerLiteral: NSUnderlineStyle.single.rawValue)
        str.addAttributes([NSAttributedString.Key.underlineStyle: number,
                           NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "#FFFFFF")?.withAlphaComponent(0.8) ?? .white,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 12)!],
                          range: strRange)
        ppButton.setAttributedTitle(str, for: UIControl.State.normal)
        ppButton.contentHorizontalAlignment = .right
        ppButton.tag = 1001
        ppButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        bottomView.addSubview(ppButton)
        ppButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.bottom.equalTo(-20)
            make.left.equalTo(0)
        }
        
        let tou = UIButton()
        let toustr = NSMutableAttributedString(string: " Terms of Use")
        let toustrRange = NSRange.init(location: 0, length: toustr.length)
        //此处必须转为NSNumber格式传给value，不然会报错
        let tounumber = NSNumber(integerLiteral: NSUnderlineStyle.single.rawValue)
        toustr.addAttributes([NSAttributedString.Key.underlineStyle: tounumber,
                              NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "#FFFFFF")?.withAlphaComponent(0.8) ?? .white,
                           NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 12)!],
                          range: toustrRange)
        tou.setAttributedTitle(toustr, for: UIControl.State.normal)
        tou.contentHorizontalAlignment = .left
        tou.tag = 1002
        tou.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        bottomView.addSubview(tou)
        tou.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.bottom.equalTo(-20)
            make.right.equalTo(-2)
        }
        
    }
    
    func findButtons(subView: UIView) {
        
        if subView.isKind(of: UIButton.classForCoder()) {
            
            if let button = subView as? UIButton {
                buttons.append(button)
            }
            return
        } else {
            subView.backgroundColor = .clear
        }
        
        for sv in subView.subviews {
            findButtons(subView: sv)
        }
    }
    
    @objc func closebuttonClick(button: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    @objc func appleButtonClick(button: UIButton) {
        let requestID = ASAuthorizationAppleIDProvider().createRequest()
                // 这里请求了用户的姓名和email
                requestID.requestedScopes = [.fullName, .email]
                
                let controller = ASAuthorizationController(authorizationRequests: [requestID])
                controller.delegate = self
                controller.presentationContextProvider = self
                controller.performRequests()
    }
    
    func customFont(fontName: String, size: CGFloat) -> UIFont {
        let stringArray: Array = fontName.components(separatedBy: ".")
        let path = Bundle.main.path(forResource: stringArray[0], ofType: stringArray[1])
        let fontData = NSData.init(contentsOfFile: path ?? "")
        
        let fontdataProvider = CGDataProvider(data: CFBridgingRetain(fontData) as! CFData)
        let fontRef = CGFont.init(fontdataProvider!)!
        
        var fontError = Unmanaged<CFError>?.init(nilLiteral: ())
        CTFontManagerRegisterGraphicsFont(fontRef, &fontError)
        
        let fontName: String =  fontRef.postScriptName as String? ?? ""
        let font = UIFont(name: fontName, size: size)
        
        fontError?.release()
        
        return font ?? UIFont(name: def_fontName, size: size)!
    }
    
    @objc func buttonClick(button: UIButton) {
        
        switch button.tag {
            
        case 1001:
            let url = URL(string: ppUrl)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            break
            
        case 1002:
            let url = URL(string: touUrl)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            break

        default:
            break
        }
    }

            
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CustomizeViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 请求完成，但是有错误
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        // 请求完成， 用户通过验证
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // 拿到用户的验证信息，这里可以跟自己服务器所存储的信息进行校验，比如用户名是否存在等。
            //                let detailVC = DetailVC(cred: credential)
            //                self.present(detailVC, animated: true, completion: nil)
            
            print(credential)
            LoginManage.saveAppleUserIDAndUserName(userID: credential.user, userName: credential.email ?? "")
            self.dismiss(animated: true) {
            }
            
        } else {
            
        }
    }
}

extension CustomizeViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return (UIApplication.shared.delegate as! AppDelegate).window!
    }
}
