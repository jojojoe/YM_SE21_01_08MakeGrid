//
//  MGymMainVC.swift
//  MGymMakeGrid
//
//  Created by JOJO on 2021/2/2.
//

import UIKit
import SnapKit
import Photos


let previewWidth: CGFloat = 330

class MGymMainVC: UIViewController, UINavigationControllerDelegate {

    let previewImgs: [String] = ["gird_cover_bg_1", "gird_cover_bg_2", "gird_cover_bg_3", "gird_cover_bg_4", "gird_cover_bg_5"]
    var collection: UICollectionView!
    let photoBtn = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FAFAFA")
        setupView()
        
    }
    

     

}

extension MGymMainVC {
    func setupView() {
        // setting btn
        let settingBtn = UIButton(type: .custom)
        view.addSubview(settingBtn)
        settingBtn.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.height.equalTo(44)
        }
        settingBtn.setImage(UIImage(named: "setting_ic"), for: .normal)
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender:)), for: .touchUpInside)
        
        // store btn
        let storeBtn = UIButton(type: .custom)
        view.addSubview(storeBtn)
        storeBtn.snp.makeConstraints {
            $0.right.equalTo(-10)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.height.equalTo(44)
        }
        storeBtn.setImage(UIImage(named: "home_shop_ic"), for: .normal)
        storeBtn.addTarget(self, action: #selector(storeBtnClick(sender:)), for: .touchUpInside)
        
        // app name
        let appNameLabel = UILabel()
        appNameLabel.text = "Grid Conllage"
        appNameLabel.textColor = UIColor(hexString: "#373737")
        appNameLabel.font = UIFont(name: "aliensandcows", size: 28)
        appNameLabel.textAlignment = .left
        view.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints {
            $0.left.equalTo(settingBtn.snp.left).offset(10)
            $0.top.equalTo(settingBtn.snp.bottom).offset(6)
            $0.height.equalTo(24)
            $0.width.greaterThanOrEqualTo(100)
        }
        
        // preview collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(20)
            $0.height.equalTo(previewWidth)
            $0.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: MGMainPreviewCell.self)
        
        // photoBtn
        photoBtn.image(UIImage(named: "home_photo_ic"))
        photoBtn.title("Select Photo")
        photoBtn.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 18)
        photoBtn.titleColor(UIColor.white)
        photoBtn.backgroundColor = UIColor(hexString: "#373737")
        photoBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        photoBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        view.addSubview(photoBtn)
        photoBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(62)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-180)
            $0.width.equalTo(254)
        }
        photoBtn.layer.cornerRadius = 31
        photoBtn.addTarget(self, action: #selector(photoBtnClick(sender:)), for: .touchUpInside)
        
        // shape btn
        let shapeBtn = MGMainBottonBtn(iconName: "home_shape_ic", name: "Shape")
        view.addSubview(shapeBtn)
        shapeBtn.addTarget(self, action: #selector(shapeBtnClick), for: .touchUpInside)
        shapeBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            $0.width.equalTo(50)
            $0.height.equalTo(76)
        }
        
        // grid btn
        let gridBtn = MGMainBottonBtn(iconName: "home_grid_ic", name: "Shape")
        view.addSubview(gridBtn)
        gridBtn.addTarget(self, action: #selector(gridBtnClick), for: .touchUpInside)
        gridBtn.snp.makeConstraints {
            $0.left.equalTo(photoBtn.snp.left)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            $0.width.equalTo(50)
            $0.height.equalTo(76)
        }
        
        // edit btn
        let editBtn = MGMainBottonBtn(iconName: "home_edit_ic", name: "Shape")
        view.addSubview(editBtn)
        editBtn.addTarget(self, action: #selector(editBtnClick), for: .touchUpInside)
        editBtn.snp.makeConstraints {
            $0.right.equalTo(photoBtn.snp.right)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            $0.width.equalTo(50)
            $0.height.equalTo(76)
        }   
    }
    
    
}

extension MGymMainVC {
    
    func checkAlbumAuthorization() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.presentPhotoPickerController()
                    }
                    
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized {
                        DispatchQueue.main.async {
                            self.presentPhotoPickerController()
                        }
                    }
                case .denied:
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        let alert = UIAlertController(title: "Oops", message: "You have declined access to photos, please active it in Settings>Privacy>Photos.", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (goSettingAction) in
                            DispatchQueue.main.async {
                                let url = URL(string: UIApplication.openSettingsURLString)!
                                UIApplication.shared.open(url, options: [:])
                            }
                        })
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                        alert.addAction(confirmAction)
                        alert.addAction(cancelAction)
                        
                        self.present(alert, animated: true)
                    }
                    
                case .restricted:
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        let alert = UIAlertController(title: "Oops", message: "You have declined access to photos, please active it in Settings>Privacy>Photos.", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (goSettingAction) in
                            DispatchQueue.main.async {
                                let url = URL(string: UIApplication.openSettingsURLString)!
                                UIApplication.shared.open(url, options: [:])
                            }
                        })
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                        alert.addAction(confirmAction)
                        alert.addAction(cancelAction)
                        
                        
                        self.present(alert, animated: true)
                    }
                default: break
                }
            }
        }
        
        
    }
    
    
    func presentPhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.allowsEditing = true
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func showEditVC(image: UIImage) {
        let editVC = MGymEditVC(image: image)
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
}


extension MGymMainVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.showEditVC(image: image)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.showEditVC(image: image)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}




extension MGymMainVC {
    @objc func settingBtnClick(sender: UIButton) {
        
        let settingView = MGSettingView()
        settingView.upVC = self
        view.addSubview(settingView)
        settingView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        settingView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            settingView.alpha = 1
        } completion: { (finished) in
            if finished {
                 
                
            }
        }
        
        
    }
    
    @objc func storeBtnClick(sender: UIButton) {
        let storeVC = MGStoreVC()
        self.navigationController?.pushViewController(storeVC)
    }
    
    @objc func photoBtnClick(sender: UIButton) {
        checkAlbumAuthorization()
    }
    
    @objc func gridBtnClick(sender: UIButton) {
        checkAlbumAuthorization()
    }
    
    @objc func shapeBtnClick(sender: UIButton) {
        checkAlbumAuthorization()
    }
    
    @objc func editBtnClick(sender: UIButton) {
        checkAlbumAuthorization()
    }
    
    
}

extension MGymMainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: MGMainPreviewCell.self, for: indexPath)
            
        if let image = UIImage(named: previewImgs[indexPath.item]) {
            cell.previewBgView.image = image
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previewImgs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension MGymMainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension MGymMainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}




class MGMainPreviewCell: UICollectionViewCell {
    
    let previewBgView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        previewBgView.contentMode = .scaleAspectFit
        contentView.addSubview(previewBgView)
        previewBgView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(previewWidth)
        }
        previewBgView.backgroundColor = .white
        
        
    }
    
}



class MGMainBottonBtn: UIControl {
    
    let iconImageV = UIImageView()
    let nameLabel = UILabel()
    
    let iconName: String
    let name: String
    
    override init(frame: CGRect) {
        self.iconName = ""
        self.name = ""
        super.init(frame: frame)
        
        setupView()
    }
    
    init(iconName: String, name: String) {
        self.iconName = iconName
        self.name = name
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        iconImageV.image = UIImage(named: iconName)
        iconImageV.contentMode = .scaleAspectFit
        addSubview(iconImageV)
        iconImageV.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.text = name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "IBMPlexSans", size: 14)
        nameLabel.textColor = UIColor(hexString: "#373737")
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageV.snp.bottom).offset(6)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        
    }
    
}



