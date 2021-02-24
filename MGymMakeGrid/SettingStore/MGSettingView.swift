//
//  MGSettingView.swift
//  MGymMakeGrid
//
//  Created by JOJO on 2021/2/7.
//

import UIKit
import MessageUI
import StoreKit
import Defaults
import NoticeObserveKit


let AppName: String = "Post Grids"
let purchaseUrl = ""
let TermsofuseURLStr = "http://late-language.surge.sh/Terms_of_use.htm"
let PrivacyPolicyURLStr = "http://late-language.surge.sh/Privacy_Agreement.htm"

let feedbackEmail: String = "postgridsmakerlike@126.com"
let AppAppStoreID: String = ""


class MGSettingView: UIView {

    var upVC: UIViewController?
    let closeBtn = UIButton(type: .custom)
    let privacyBtn = UIButton(type: .custom)
    let termsBtn = UIButton(type: .custom)
    let feedbackBtn = UIButton(type: .custom)
    let loginBtn = UIButton(type: .custom)
    let logoutBtn = UIButton(type: .custom)
    
    let accountBgView = UIView()
    let coinInfoBgView = UIView()
    let userNameLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        setupView()
        updateUserAccountStatus()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension MGSettingView {
    func updateUserAccountStatus() {
        if let userModel = LoginManage.currentLoginUser() {
            let userName  = userModel.userName
            userNameLabel.text = (userName?.count ?? 0) > 0 ? userName : "Tourist"
            accountBgView.isHidden = false
            logoutBtn.isHidden = false
            loginBtn.isHidden = true
        } else {
            userNameLabel.text = ""
            accountBgView.isHidden = true
            logoutBtn.isHidden = true
            loginBtn.isHidden = false
        }
    }
}

extension MGSettingView {
    func setupView() {
        
        // blur
        
        let blur = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView.init(effect: blur)
        addSubview(effectView)
        effectView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        
        closeBtn.image(UIImage(named: "setting_close_ic"))
        addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-50)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        closeBtn.addTarget(self, action: #selector(closeBtnClick(sender:)), for: .touchUpInside)
        
        privacyBtn.setTitleColor(UIColor.white, for: .normal)
        privacyBtn.titleLabel?.font = UIFont(name: "IBMPlexSans-SemiBold", size: 24)
        privacyBtn.setTitle("Privacy Policy", for: .normal)
        addSubview(privacyBtn)
        privacyBtn.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.center.equalToSuperview()
        }
        privacyBtn.addTarget(self, action: #selector(privacyBtnClick(sender:)), for: .touchUpInside)
        
        
        termsBtn.setTitleColor(UIColor.white, for: .normal)
        termsBtn.titleLabel?.font = UIFont(name: "IBMPlexSans-SemiBold", size: 24)
        termsBtn.setTitle("Terms of use", for: .normal)
        addSubview(termsBtn)
        termsBtn.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(privacyBtn.snp.top).offset(-10)
            
        }
        termsBtn.addTarget(self, action: #selector(termsBtnClick(sender:)), for: .touchUpInside)
        
        
        feedbackBtn.setTitleColor(UIColor.white, for: .normal)
        feedbackBtn.titleLabel?.font = UIFont(name: "IBMPlexSans-SemiBold", size: 24)
        feedbackBtn.setTitle("Feedback", for: .normal)
        addSubview(feedbackBtn)
        feedbackBtn.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(privacyBtn.snp.bottom).offset(10)
        }
        feedbackBtn.addTarget(self, action: #selector(feedbackBtnClick(sender:)), for: .touchUpInside)
        
        // login
        
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont(name: "IBMPlexSans-SemiBold", size: 24)
        loginBtn.setTitle("Log in", for: .normal)
        addSubview(loginBtn)
        loginBtn.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(termsBtn.snp.top).offset(-10)
        }
        loginBtn.addTarget(self, action: #selector(loginBtnClick(sender:)), for: .touchUpInside)
        
        // logout
        
        logoutBtn.setTitleColor(UIColor(hexString: "#A8A8A8"), for: .normal)
        logoutBtn.titleLabel?.font = UIFont(name: "IBMPlexSans-SemiBold", size: 24)
        logoutBtn.setTitle("Log out", for: .normal)
        addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(feedbackBtn.snp.bottom).offset(10)
        }
        logoutBtn.addTarget(self, action: #selector(logoutBtnClick(sender:)), for: .touchUpInside)
        
        accountBgView.backgroundColor = .clear
        addSubview(accountBgView)
        
        accountBgView.snp.makeConstraints {
            $0.bottom.equalTo(loginBtn.snp.top).offset(0)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        // user name label
        
        accountBgView.addSubview(userNameLabel)
        userNameLabel.textAlignment = .center
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont(name: "IBMPlexSans-SemiBold", size: 24)
        userNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(35)
            $0.top.equalToSuperview()
        }
        
         
        // coin info bg view
        let topCoinLabel = UILabel()
        topCoinLabel.textAlignment = .right
        topCoinLabel.text = "\(CoinManager.default.coinCount)"
        topCoinLabel.textColor = UIColor(hexString: "#FFFFFF")
        topCoinLabel.font = UIFont(name: "IBMPlexSans-Medium", size: 18)
        accountBgView.addSubview(topCoinLabel)
        topCoinLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview().offset(14)
            $0.height.equalTo(35)
            $0.width.greaterThanOrEqualTo(25)
        }
        
        let coinImageV = UIImageView()
        coinImageV.image = UIImage(named: "coin_ic")
        coinImageV.contentMode = .scaleAspectFit
        accountBgView.addSubview(coinImageV)
        coinImageV.snp.makeConstraints {
            $0.centerY.equalTo(topCoinLabel)
            $0.right.equalTo(topCoinLabel.snp.left).offset(-10)
            $0.width.height.equalTo(20)
        }
        

        
        
    }
}


extension MGSettingView {
    @objc func privacyBtnClick(sender: UIButton) {
        UIApplication.shared.openURL(url: PrivacyPolicyURLStr)
    }
    
    @objc func termsBtnClick(sender: UIButton) {
        UIApplication.shared.openURL(url: TermsofuseURLStr)
    }
    
    @objc func feedbackBtnClick(sender: UIButton) {
        feedback()
    }
    
    @objc func loginBtnClick(sender: UIButton) {
        closeBtnClick(sender: closeBtn)
        if let mainVC = self.upVC as? MGymMainVC {
            mainVC.showLoginVC()
        }
        
    }
    
    @objc func logoutBtnClick(sender: UIButton) {
        LoginManage.shared.logout()
        updateUserAccountStatus()
    }
    
    
    @objc func closeBtnClick(sender: UIButton) {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { (finished) in
            if finished {
                DispatchQueue.main.async {
                    [weak self] in
                    guard let `self` = self else {return}
                    self.removeFromSuperview()
                }
            }
        }
    }
}



extension MGSettingView: MFMailComposeViewControllerDelegate {
   func feedback() {
       //首先要判断设备具不具备发送邮件功能
       if MFMailComposeViewController.canSendMail(){
           //获取系统版本号
           let systemVersion = UIDevice.current.systemVersion
           let modelName = UIDevice.current.modelName
           
           let infoDic = Bundle.main.infoDictionary
           // 获取App的版本号
           let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
           // 获取App的名称
           let appName = "\(AppName)"

           
           let controller = MFMailComposeViewController()
           //设置代理
           controller.mailComposeDelegate = self
           //设置主题
           controller.setSubject("\(appName) Feedback")
           //设置收件人
           // FIXME: feed back email
           controller.setToRecipients([feedbackEmail])
           //设置邮件正文内容（支持html）
        controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
           
           //打开界面
        self.upVC?.present(controller, animated: true, completion: nil)
       }else{
           HUD.error("The device doesn't support email")
       }
   }
   
   //发送邮件代理方法
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       controller.dismiss(animated: true, completion: nil)
   }
}


extension UIDevice {
  
   ///The device model name, e.g. "iPhone 6s", "iPhone SE", etc
   var modelName: String {
       var systemInfo = utsname()
       uname(&systemInfo)
      
       let machineMirror = Mirror(reflecting: systemInfo.machine)
       let identifier = machineMirror.children.reduce("") { identifier, element in
           guard let value = element.value as? Int8, value != 0 else {
               return identifier
           }
           return identifier + String(UnicodeScalar(UInt8(value)))
       }
      
       switch identifier {
           case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iphone 4"
           case "iPhone4,1":                               return "iPhone 4s"
           case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
           case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
           case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
           case "iPhone7,2":                               return "iPhone 6"
           case "iPhone7,1":                               return "iPhone 6 Plus"
           case "iPhone8,1":                               return "iPhone 6s"
           case "iPhone8,2":                               return "iPhone 6s Plus"
           case "iPhone8,4":                               return "iPhone SE"
           case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
           case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
           case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
           case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
           case "iPhone10,3", "iPhone10,6":                return "iPhone X"
           case "iPhone11,2":                              return "iPhone XS"
           case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
           case "iPhone11,8":                              return "iPhone XR"
           case "iPhone12,1":                              return "iPhone 11"
           case "iPhone12,3":                              return "iPhone 11 Pro"
           case "iPhone12,5":                              return "iPhone 11 Pro Max"
           case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
           case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
           case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
           case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
           case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
           case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
           case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
           case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
           case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
           case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
           case "AppleTV5,3":                              return "Apple TV"
           case "i386", "x86_64":                          return "Simulator"
           default:                                        return identifier
       }
   }
}

