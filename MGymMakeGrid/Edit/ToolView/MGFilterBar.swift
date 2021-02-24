//
//  MGFilterBar.swift
//  MGymMakeGrid
//
//  Created by JOJO on 2021/2/8.
//

import UIKit

class GCToolFilterView: UIView {

    var collection: UICollectionView!
    var didSelectFilterItemBlock: ((_ filterItem: GCFilterItem) -> Void)?
    var currentSelectIndexPath : IndexPath?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadData()
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        currentSelectIndexPath = IndexPath(item: 0, section: 0)
        collection.selectItem(at: currentSelectIndexPath, animated: false, scrollPosition: .centeredHorizontally)
    }

}

extension GCToolFilterView {
    func loadData() {
        
    }
    
    func setupView() {
        // collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(100)
        }
        collection.register(cellWithClass: GCFilterCell.self)
    }
    
    
}


extension GCToolFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: GCFilterCell.self, for: indexPath)
        let item = DataManager.default.filterList[indexPath.item]
        let image_o = UIImage(named: "filter_o")
        let filteredImg = DataManager.default.filterOriginalImage(image: image_o!, lookupImgNameStr: item.imageName)
        if item.filterName == "Original" {
            cell.contentImageView.image = UIImage(named: item.imageName) ?? image_o
        } else {
            cell.contentImageView.image = filteredImg //UIImage.named("\(item.filterName)")
        }
        cell.nameLabel.text = item.filterName
        
        if currentSelectIndexPath?.item == indexPath.item {
            cell.selectView.isHidden = false
        } else {
            cell.selectView.isHidden = true
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.default.filterList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension GCToolFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}

extension GCToolFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = DataManager.default.filterList[indexPath.item]
        currentSelectIndexPath = indexPath
        didSelectFilterItemBlock?(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}






class GCFilterCell: UICollectionViewCell {
    var contentImageView: UIImageView = UIImageView()
    let selectView: UIView = UIView()
    let nameLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 4
        contentImageView.contentMode = .scaleAspectFill
        contentView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        
        selectView.isHidden = true
        selectView.backgroundColor = .clear
        selectView.layer.cornerRadius = 4
        selectView.layer.borderWidth = 1
        selectView.layer.borderColor = UIColor(hexString: "#000000")?.cgColor
        contentView.addSubview(selectView)
        selectView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.backgroundColor = UIColor(hexString: "#373737")?.withAlphaComponent(0.7)
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor(hexString: "#FFFFFF")
        nameLabel.font = UIFont(name: "IBMPlexSans-Medium", size: 8)
        nameLabel.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(20)
        }
        
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectView.isHidden = false
            } else {
                selectView.isHidden = true
            }
        }
    }
    
}


