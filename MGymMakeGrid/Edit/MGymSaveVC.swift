//
//  MGymSaveVC.swift
//  MGymMakeGrid
//
//  Created by JOJO on 2021/2/10.
//

import UIKit
import NoticeObserveKit
import Photos

class MGymSaveVC: UIViewController {
    private var pool = Notice.ObserverPool()
    let backBtn = UIButton(type: .custom)
    let topCoinLabel = UILabel()
    let canvasView = UIView()
    
    var bigImage: UIImage
    var previewImage: UIImage
    
    init(bigImage_save: UIImage, previewImage_small: UIImage) {
        self.bigImage = bigImage_save
        self.previewImage = previewImage_small
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationObserver()
        setupView()
    }
    
    
    func addNotificationObserver() {
        
        NotificationCenter.default.nok.observe(name: .pi_noti_coinChange) {[weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.topCoinLabel.text = "\(CoinManager.default.coinCount)"
            }
        }
        .invalidated(by: pool)
        
         
    }

    
    func setupView() {
     
        view.addSubview(backBtn)
        backBtn.setImage(UIImage(named: "back_ic"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        
        // canvasView
        canvasView.backgroundColor = .clear
        view.addSubview(canvasView)
        canvasView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-160)
//            $0.width.height.equalTo(previewWidth)
        }
        
        let contentImageView = UIImageView()
        contentImageView.image = previewImage
        view.addSubview(contentImageView)
        contentImageView.contentMode = .scaleAspectFit
        canvasView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints {
            $0.center
            $0.width.height.equalTo(previewWidth)
        }
        
        // top coin label
        topCoinLabel.textAlignment = .right
        topCoinLabel.text = "\(CoinManager.default.coinCount)"
        
        topCoinLabel.textColor = UIColor(hexString: "#2A2A2A")
        topCoinLabel.font = UIFont(name: "IBMPlexSans-Medium", size: 18)
        view.addSubview(topCoinLabel)
        topCoinLabel.snp.makeConstraints {
            $0.centerY.equalTo(backBtn)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(30)
            $0.width.greaterThanOrEqualTo(25)
        }
        
        let coinImageV = UIImageView()
        coinImageV.image = UIImage(named: "coin_ic")
        coinImageV.contentMode = .scaleAspectFit
        view.addSubview(coinImageV)
        coinImageV.snp.makeConstraints {
            $0.centerY.equalTo(topCoinLabel)
            $0.right.equalTo(topCoinLabel.snp.left).offset(-4)
            $0.width.height.equalTo(20)
        }
        
        // save btn
        let saveBtn = UIButton(type: .custom)
        saveBtn.backgroundColor = UIColor(hexString: "#373737")
        saveBtn.setTitle("Save Now", for: .normal)
        saveBtn.setTitleColor(UIColor.white, for: .normal)
        saveBtn.titleLabel?.font = UIFont(name: "IBMPlexSans", size: 18)
        view.addSubview(saveBtn)
        saveBtn.snp.makeConstraints {
            $0.top.equalTo(canvasView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(254)
            $0.height.equalTo(62)
        }
        saveBtn.layer.cornerRadius = 31
        saveBtn.layer.masksToBounds = true
        saveBtn.addTarget(self, action: #selector(saveBtnClick(sender:)), for: .touchUpInside)
    }
     
    @objc func saveBtnClick(sender: UIButton) {
        let imgs = processDivisionImages(originalImage: bigImage)
        saveImgsToAlbum(imgs: imgs)
    }

}

extension MGymSaveVC {
    
    func saveImgsToAlbum(imgs: [UIImage]) {
         
        
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized {
            saveToAlbumPhotoAction(images: imgs)
        } else if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization({[weak self] (status) in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    if status != .authorized {

                        return
                    }
                    self.saveToAlbumPhotoAction(images: imgs)
                }
            })
        } else {
            // 权限提示
//            showPhotoNoAuthorizedAlert()
        }
        
    }
    
    func saveToAlbumPhotoAction(images: [UIImage]) {
        DispatchQueue.main.async(execute: {
            PHPhotoLibrary.shared().performChanges({
                [weak self] in
                guard let `self` = self else {return}
                for img in images {
                    PHAssetChangeRequest.creationRequestForAsset(from: img)
                }
//                self.showSaveSuccessAlert()
            }) { (finish, error) in
                if error != nil {
                    HUD.error("Sorry! please try again")
                }
            }
        })
    }
    
    
    func processDivisionImages(originalImage: UIImage) -> [UIImage] {
        
        
        let widthLengthCount = 3
        let heightLengthCount = 3
        let devideLineWidth = 0

        var contentSubViewRect: [CGRect] = []
        
        let perWidthLengh: CGFloat = CGFloat(Int(originalImage.size.width) - (widthLengthCount - 1) * devideLineWidth) / CGFloat(widthLengthCount)
        let perHeightLengh: CGFloat = CGFloat(Int(originalImage.size.height) - (heightLengthCount - 1) * devideLineWidth) / CGFloat(heightLengthCount)
        
        let allImageCount = widthLengthCount * heightLengthCount;
        
        for index in 0..<allImageCount {
            let hangCount = index / widthLengthCount;
            let lieCount = index % heightLengthCount;
            let x: CGFloat = perWidthLengh * CGFloat(lieCount) + CGFloat(devideLineWidth) * CGFloat(lieCount)
            let y: CGFloat = perHeightLengh * CGFloat(hangCount) + CGFloat(devideLineWidth) * CGFloat(hangCount)
            let contentImageViewRect = CGRect.init(x: x, y: y, width: perWidthLengh, height: perHeightLengh)
            
            contentSubViewRect.append(contentImageViewRect)
        }
        let divisionSize = CGSize.init(width: perWidthLengh, height: perHeightLengh)
        var divisionImgs: [UIImage] = []
        for itemRect in contentSubViewRect {
            
            UIGraphicsBeginImageContextWithOptions(divisionSize, false, UIScreen.main.scale)
            // Always remember to close the image context when leaving
            defer { UIGraphicsEndImageContext() }
            
            originalImage.draw(in: CGRect(x: -itemRect.origin.x, y: -itemRect.origin.y, width: originalImage.size.width, height: originalImage.size.height))
            
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                // Set the textColor to the new created gradient color
                divisionImgs.append(image)
            }
        }
        return divisionImgs
    }
}


extension MGymSaveVC {
    @objc func backBtnClick(sender: UIButton) {
        
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController()
        }
    }
}





