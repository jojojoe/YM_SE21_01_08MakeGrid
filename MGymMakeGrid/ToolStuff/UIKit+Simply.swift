//
//  SimplyExtension.swift
//  guru_iOS
//
//  Created by Di on 2018/12/6.
//  Copyright © 2018 gelonghui. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    @discardableResult
    func crop() -> Self {
        contentMode()
        clipsToBounds()
        return self
    }

    @discardableResult
    func alpha(_ value: CGFloat) -> Self {
        alpha = value
        return self
    }

    @discardableResult
    func hidden(_ value: Bool = true) -> Self {
        isHidden = value
        return self
    }
    
    @discardableResult
    func show(_ value: Bool = true) -> Self {
        isHidden = !value
        return self
    }

    @discardableResult
    func cornerRadius(_ value: CGFloat, masksToBounds: Bool = true) -> Self {
        layer.cornerRadius = value
        layer.masksToBounds = masksToBounds
        return self
    }

    @discardableResult
    func borderColor(_ value: UIColor, width: CGFloat = UIScreen.minLineWidth) -> Self {
        layer.borderColor = value.cgColor
        layer.borderWidth = width
        return self
    }

    @discardableResult
    func contentMode(_ value: UIView.ContentMode = .scaleAspectFill) -> Self {
        contentMode = value
        return self
    }

    @discardableResult
    func clipsToBounds(_ value: Bool = true) -> Self {
        clipsToBounds = value
        return self
    }

    @discardableResult
    func tag(_ value: Int) -> Self {
        tag = value
        return self
    }

    @discardableResult
    func tintColor(_ value: UIColor) -> Self {
        tintColor = value
        return self
    }

    @discardableResult
    func backgroundColor(_ value: UIColor) -> Self {
        backgroundColor = value
        return self
    }

    @discardableResult
    func isUserInteractionEnabled(_ value: Bool = true) -> Self {
        isUserInteractionEnabled = value
        return self
    }
}

public extension UIFont {
    enum FontNames: String {
        case SFProTextBold = "SFProText-Bold"
        case SFProTextSemibold = "SFProText-Semibold"
        case SFProTextMedium = "SFProText-Medium"
        case SFProTextRegular = "SFProText-Regular"
        case NewYorkMediumRegular = "NewYorkMedium-Regular"
        case Pilgiche_JCfg = "JCfg"
        case BalooBhaiRegular = "BalooBhai-Regular"
        case MontserratBold = "Montserrat-Bold"
        case MonotonRegular = "Monoton-Regular"
        case HACKED = "HACKED"
        case NewYorkExtraLargeBold = "NewYorkExtraLarge-Bold"
        case PhosphateSolid = "Phosphate-Solid"
        case PhosphateInline = "Phosphate-Inline"
        case Quentin = "Quentin"
        case PoiretOneRegular = "PoiretOne-Regular"
        case Frijole = "Frijole"
        case Didot = "Didot"
        case DidotItalic = "Didot-Italic"
        case DidotBold = "Didot-Bold"
        case Digiface = "Digiface"
        case TWInkbabyRegular = "TWInkbaby-Regular"
        case AvenirBook = "Avenir-Book"
        case AvenirRoman = "Avenir-Roman"
        case AvenirBookOblique = "Avenir-BookOblique"
        case AvenirOblique = "Avenir-Oblique"
        case AvenirLight = "Avenir-Light"
        case AvenirLightOblique = "Avenir-LightOblique"
        case AvenirMedium = "Avenir-Medium"
        case AvenirMediumOblique = "Avenir-MediumOblique"
        case AvenirHeavy = "Avenir-Heavy"
        case AvenirHeavyOblique = "Avenir-HeavyOblique"
        case AvenirBlack = "Avenir-Black"
        case AvenirBlackOblique = "Avenir-BlackOblique"
        case AvenirNextRegular = "AvenirNext-Regular"
        case AvenirNextItalic = "AvenirNext-Italic"
        case AvenirNextUltraLight = "AvenirNext-UltraLight"
        case AvenirNextUltraLightItalic = "AvenirNext-UltraLightItalic"
        case AvenirNextMedium = "AvenirNext-Medium"
        case AvenirNextMediumItalic = "AvenirNext-MediumItalic"
        case AvenirNextDemiBold = "AvenirNext-DemiBold"
        case AvenirNextDemiBoldItalic = "AvenirNext-DemiBoldItalic"
        case AvenirNextBold = "AvenirNext-Bold"
        case AvenirNextBoldItalic = "AvenirNext-BoldItalic"
        case AvenirNextHeavy = "AvenirNext-Heavy"
        case Helvetica = "Helvetica"
        case HelveticaOblique = "Helvetica-Oblique"
        case HelveticaLight = "Helvetica-Light"
        case HelveticaLightOblique = "Helvetica-LightOblique"
        case HelveticaBold = "Helvetica-Bold"
        case HelveticaBoldOblique = "Helvetica-BoldOblique"
    }

    static func custom(_ value: CGFloat, name: FontNames) -> UIFont {
        return UIFont(name: name.rawValue, size: value) ?? UIFont.systemFont(ofSize: value)
    }
}

public extension UILabel {
    @discardableResult
    func text(_ value: String?) -> Self {
        text = value
        return self
    }

    @discardableResult
    func color(_ value: UIColor) -> Self {
        textColor = value
        return self
    }

    @discardableResult
    func font(_ value: CGFloat, _ bold: Bool = false) -> Self {
        font = bold ? UIFont.boldSystemFont(ofSize: value) : UIFont.systemFont(ofSize: value)
        return self
    }

    @discardableResult
    func font(_ value: CGFloat, _ name: UIFont.FontNames) -> Self {
        font = UIFont(name: name.rawValue, size: value)
        return self
    }
    
    func fontName(_ value: CGFloat, _ name: String) -> Self {
        font = UIFont(name: name, size: value)
        return self
    }
    
    @discardableResult
    func numberOfLines(_ value: Int = 0) -> Self {
        numberOfLines = value
        return self
    }

    @discardableResult
    func textAlignment(_ value: NSTextAlignment) -> Self {
        textAlignment = value
        return self
    }

    @discardableResult
    func lineBreakMode(_ value: NSLineBreakMode = .byTruncatingTail) -> Self {
        lineBreakMode = value
        return self
    }
}

public extension UIButton {
    @discardableResult
    func title(_ value: String?, _ state: UIControl.State = .normal) -> Self {
        setTitle(value, for: state)
        return self
    }

    @discardableResult
    func titleColor(_ value: UIColor, _ state: UIControl.State = .normal) -> Self {
        setTitleColor(value, for: state)
        return self
    }

    @discardableResult
    func image(_ value: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setImage(value, for: state)
        return self
    }

    @discardableResult
    func backgroundImage(_ value: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setBackgroundImage(value, for: state)
        return self
    }

    @discardableResult
    func backgroundColor(_ value: UIColor, _ state: UIControl.State = .normal) -> Self {
        setBackgroundColor(value, for: state)
        return self
    }

    @discardableResult
    func font(_ value: CGFloat, _ bold: Bool = false) -> Self {
        titleLabel?.font(value, bold)
        return self
    }

    @discardableResult
    func font(_ value: CGFloat, _ name: UIFont.FontNames) -> Self {
        titleLabel?.font(value, name)
        return self
    }

    @discardableResult
    func lineBreakMode(_ value: NSLineBreakMode = .byTruncatingTail) -> Self {
        titleLabel?.lineBreakMode(value)
        return self
    }

    @discardableResult
    func isEnabled(_ value: Bool = false) -> Self {
        isEnabled = value
        return self
    }

    @discardableResult
    func showsTouch(_ value: Bool = true) -> Self {
        showsTouchWhenHighlighted = value
        return self
    }
}

public extension UIImageView {
    @discardableResult
    func image(_ value: String?, _: Bool = false) -> Self {
        guard let value = value else { return self }
        image = UIImage(named: value) ?? UIImage.named(value)
        return self
    }
}


extension UITextView {
    
    private struct RuntimeKey {
        static let hw_placeholderLabelKey = UnsafeRawPointer.init(bitPattern: "hw_placeholderLabelKey".hashValue)
        /// ...其他Key声明
    }
    /// 占位文字
    @IBInspectable public var placeholder: String {
        get {
            return self.placeholderLabel.text ?? ""
        }
        set {
            self.placeholderLabel.text = newValue
        }
    }
    
    /// 占位文字颜色
    @IBInspectable public var placeholderColor: UIColor {
        get {
            return self.placeholderLabel.textColor
        }
        set {
            self.placeholderLabel.textColor = newValue
        }
    }
    
    private var placeholderLabel: UILabel {
        get {
            var label = objc_getAssociatedObject(self, UITextView.RuntimeKey.hw_placeholderLabelKey!) as? UILabel
            if label == nil { // 不存在是 创建 绑定
                if (self.font == nil) { // 防止没大小时显示异常 系统默认设置14
                    self.font = UIFont.systemFont(ofSize: 14)
                }
                label = UILabel.init(frame: self.bounds)
                label?.numberOfLines = 0
                label?.font = UIFont.systemFont(ofSize: 14)//self.font
                label?.textColor = UIColor.lightGray
                label?.textAlignment = self.textAlignment
                self.addSubview(label!)
                self.setValue(label!, forKey: "_placeholderLabel")
                objc_setAssociatedObject(self, UITextView.RuntimeKey.hw_placeholderLabelKey!, label!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.sendSubviewToBack(label!)
            } else {
                label?.font = self.font
                label?.textColor = label?.textColor.withAlphaComponent(0.6)
            }
            return label!
        }
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.hw_placeholderLabelKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
