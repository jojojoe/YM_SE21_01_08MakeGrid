//
//  MGStoreVC.swift
//  MGymMakeGrid
//
//  Created by JOJO on 2021/2/7.
//

import UIKit
import NoticeObserveKit

class MGStoreVC: UIViewController {
    private var pool = Notice.ObserverPool()
    let topCoinLabel = UILabel()
    var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FAFAFA")
        setupView()
        setupCollection()
        addNotificationObserver()
    }
    
    func addNotificationObserver() {
        
        NotificationCenter.default.nok.observe(name: .pi_noti_coinChange) {[weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.topCoinLabel.text = "\(CoinManager.default.coinCount)"
            }
        }
        .invalidated(by: pool)
        
        NotificationCenter.default.nok.observe(name: .pi_noti_priseFetch) { [weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
            
        }
        .invalidated(by: pool)
    }

}

extension MGStoreVC {
    func setupView() {
        let backBtn = UIButton(type: .custom)
        view.addSubview(backBtn)
        backBtn.setImage(UIImage(named: "back_ic"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        
        let titleLabel = UILabel(text: "Coins Store")
        titleLabel.font = UIFont(name: "IBMPlexSans-Medium", size: 14)
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
        titleLabel.textColor = UIColor(hexString: "#121212")
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backBtn)
            $0.left.equalTo(backBtn.snp.right)
            $0.height.equalTo(28)
            $0.width.equalTo(100)
        }
        
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
        
        
        
    }
    
    func setupCollection() {
        // collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            $0.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collection.register(cellWithClass: GCStoreCell.self)
    }
    
    func selectCoinItem(item: StoreItem) {
        CoinManager.default.purchaseIapId(iap: item.iapId) { (success, errorString) in
            
            if success {
                CoinManager.default.addCoin(coin: item.coin)
                self.showAlert(title: "Purchase successful.", message: "")
            } else {
                self.showAlert(title: "Purchase failed.", message: errorString)
            }
        }
    }
}

extension MGStoreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GCStoreCell.self, for: indexPath)
        let item = CoinManager.default.coinIpaItemList[indexPath.item]
        cell.coinCountLabel.text = "\(item.coin)"
        cell.priceLabel.text = item.price
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoinManager.default.coinIpaItemList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension MGStoreVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 138, height: 138)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
}

extension MGStoreVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = CoinManager.default.coinIpaItemList[safe: indexPath.item] {
            selectCoinItem(item: item)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}


extension MGStoreVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController()
        }
    }
}








class GCStoreCell: UICollectionViewCell {
    
    var bgView: UIView = UIView()
    
    var bgImageV: UIImageView = UIImageView()
    var coverImageV: UIImageView = UIImageView().image("coin_ic")
    var coinCountLabel: UILabel = UILabel()
    var priceLabel: UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgroundColor = UIColor.clear
        bgView.backgroundColor = .clear
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        bgImageV.backgroundColor = UIColor.white
        bgImageV.layer.cornerRadius = 8
        bgImageV.layer.masksToBounds = true
        bgView.addSubview(bgImageV)
        bgImageV.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        coverImageV.contentMode = .center
        bgView.addSubview(coverImageV)
        coverImageV.snp.makeConstraints {
            $0.right.equalTo(-16)
            $0.top.equalTo(16)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
        
        coinCountLabel.adjustsFontSizeToFitWidth = true
        coinCountLabel.textColor = UIColor(hexString: "#121212")
        coinCountLabel.textAlignment = .left
        coinCountLabel.font = UIFont(name: "IBMPlexSans-Bold", size: 18)
        coinCountLabel.textColor = UIColor(hexString: "#121212")
        coinCountLabel.adjustsFontSizeToFitWidth = true
        bgView.addSubview(coinCountLabel)
        coinCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(coverImageV.snp.centerY)
            $0.left.equalTo(16)
            $0.right.equalTo(coverImageV.snp.left).offset(-4)
            $0.height.equalTo(25)
        }
        
        let coinDesLabel = UILabel(text: "coins")
        coinDesLabel.textAlignment = .left
        coinDesLabel.font = UIFont(name: "IBMPlexSans-Bold", size: 18)
        coinDesLabel.textColor = UIColor(hexString: "#121212")
        coinDesLabel.adjustsFontSizeToFitWidth = true
        bgView.addSubview(coinDesLabel)
        coinDesLabel.snp.makeConstraints {
            $0.top.equalTo(coverImageV.snp.centerY)
            $0.left.equalTo(16)
            $0.right.equalTo(coverImageV.snp.left).offset(-4)
            $0.height.equalTo(25)
        }
        
        priceLabel.textColor = UIColor(hexString: "#FFFFFF")
        priceLabel.font = UIFont(name: "IBMPlexSans-SemiBold", size: 18)
        priceLabel.textAlignment = .center
        bgView.addSubview(priceLabel)
        priceLabel.backgroundColor = UIColor(hexString: "#373737")
        priceLabel.cornerRadius = 8
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(coverImageV.snp.bottom).offset(20)
            $0.right.equalTo(-16)
            $0.left.equalTo(16)
            $0.bottom.equalToSuperview().offset(-18)
        }
        
    }
    
    override var isSelected: Bool {
        didSet {
            
            if isSelected {
                
            } else {
                
            }
        }
    }
}

