//
//  MGGridBar.swift
//  MGymMakeGrid
//
//  Created by JOJO on 2021/2/8.
//

import UIKit

class MGGridBar: UIView {

    let colorView = SWBgColorView()
    let gridView = MGGrideSelectView()
    let slider: UISlider = UISlider()
    
    var alphaChangeBlock: ((CGFloat)->Void)?
    var colorChangeBlock: ((String)->Void)?
    var selectGridList: ((GridItem)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MGGridBar {
    func setupView() {
        
        slider.minimumTrackTintColor = UIColor.black
        slider.maximumTrackTintColor = UIColor.lightGray
        slider.setThumbImage(UIImage.named("sliderPoint"), for: .normal)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.7
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .valueChanged)
        addSubview(slider)
        slider.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-75)
            $0.height.equalTo(34)
        }
        
        let minLabel = UILabel(text: "0")
        minLabel.adjustsFontSizeToFitWidth = true
        minLabel.font = UIFont(name: "IBMPlexSans-SemiBold", size: 12)
        minLabel.textColor = UIColor(hexString: "#373737")
        addSubview(minLabel)
        minLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.height.equalTo(20)
            $0.width.equalTo(12)
            $0.centerY.equalTo(slider.snp.centerY)
        }
        
        let maxLabel = UILabel(text: "100%")
        maxLabel.adjustsFontSizeToFitWidth = true
        maxLabel.font = UIFont(name: "IBMPlexSans-SemiBold", size: 12)
        maxLabel.textColor = UIColor(hexString: "#373737")
        addSubview(maxLabel)
        maxLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-30)
            $0.height.equalTo(20)
            $0.width.equalTo(35)
            $0.centerY.equalTo(slider.snp.centerY)
        }

        // color view
        colorView.didSelectColorBlock = {
             item in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {return}
                self.colorChangeBlock?(item)
                
            }
        }
//        colorView
        addSubview(colorView)
        colorView.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
//        gridView
        gridView.didSelectGridBlock = {
            item in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {return}
                self.selectGridList?(item)
                
            }
        }
        addSubview(gridView)
        gridView.snp.makeConstraints {
            $0.bottom.equalTo(-10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        
    }
    
    
    @objc func sliderValueChange(sender: UISlider) {
        debugPrint("slider change: \(sender.value)")
        let scale: CGFloat = CGFloat(sender.value)
        alphaChangeBlock?(scale)
    }
    
    
}





