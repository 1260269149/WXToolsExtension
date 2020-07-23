//
//  UIView+Extension.swift
//  DoctorProject
//
//  Created by Ly on 2020/7/20.
//  Copyright © 2020 Ly. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    func wx_addSelectedTap(handler: ((_ view:UIView?)->())?) {
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self) { (tap) in
            handler?(tap.view)
        }
        self.addGestureRecognizer(tap)
    }
    
    @discardableResult
    func wx_addButtomLine(_ left:CGFloat = 0 ,_ right:CGFloat = 0, color: UIColor? = UIColor.light) -> UILabel {
        var line = self.viewWithTag(9999991) as? UILabel
        if line != nil {
            line?.snp.updateConstraints({
                $0.left.equalTo(left)
                $0.right.equalTo(right)
            })
            return line!
        }
        else{
            line = UILabel()
            line?.tag = 9999991
            self.addSubview(line!)
            line?.snp.makeConstraints({ (maek) in
                maek.bottom.equalTo(0)
                maek.height.equalTo(0.5)
                maek.left.equalTo(left)
                maek.right.equalTo(right)
            })
            line?.backgroundColor = color
            return line!
        }
    }
    
    func wx_addTopLine(_ left:CGFloat = 0 ,_ right:CGFloat = 0, color: UIColor? = kTablewSegLineColor) -> UILabel {
        var line = self.viewWithTag(9999992) as? UILabel
        if line != nil {
            line?.snp.updateConstraints({
                $0.left.equalTo(left)
                $0.right.equalTo(right)
            })
            return line!
        }
        else{
            line = UILabel()
            line?.tag = 9999992
            self.addSubview(line!)
            line?.snp.makeConstraints({ (maek) in
                maek.top.equalTo(0)
                maek.height.equalTo(0.5)
                maek.left.equalTo(left)
                maek.right.equalTo(right)
            })
            line?.backgroundColor = color
            return line!
        }
    }
    
    ///初始化View 设置背景颜色
    class func ch_view(_ backgroundColor: UIColor) -> Self {
        return ch_base_view(backgroundColor)
    }
    
    ///初始化View 设置背景颜色、圆角
    class func ch_view(_ backgroundColor: UIColor, _ cornerRadius: CGFloat) -> Self {
        return ch_base_view(backgroundColor, cornerRadius)
    }
    
    ///设置View 背景颜色、圆角
    func ch_view(_ backgroundColor: UIColor, _ cornerRadius: CGFloat)  {
        ch_base_view(backgroundColor, cornerRadius)
    }
    
    /// 水平渐变
    func ch_horizontalGradientLayer(_ startColor: UIColor, _ endColor: UIColor, _ cornerRadius:CGFloat) {
        ch_base_horizontalGradientLayer(startColor, endColor, cornerRadius)
    }
    
    /// 垂直渐变
    func ch_verticalGradientLayer(_ startColor: UIColor, _ endColor: UIColor, _ cornerRadius:CGFloat) {
        ch_base_verticalGradientLayer(startColor, endColor, cornerRadius)
    }
    
    ///设置多角圆角
    func ch_roundingCorner(_ corners: UIRectCorner, _ radii: CGFloat) {
        ch_base_roundingCorner(corners, radii)
    }
    
    ///给View添加阴影
    func ch_shadow( _ shadowColor:UIColor, _ shadowOffset:CGSize, _ shadowOpacity:Float, _ shadowRadius:CGFloat, _ cornerRadius:CGFloat) {
        ch_base_shadow(shadowColor, shadowOffset, shadowOpacity, shadowRadius, cornerRadius)
    }
    
    ///给View添加阴影和边框
    func ch_shadowBorder( _ shadowColor:UIColor, _ shadowOffset:CGSize, _ shadowOpacity:Float, _ shadowRadius:CGFloat, _ cornerRadius:CGFloat, _ borderColor: UIColor) {
        ch_base_shadowBorder(shadowColor, shadowOffset, shadowOpacity, shadowRadius, cornerRadius,borderColor)
    }
    
    ///获取当前View的控制器
    func ch_viewGetcurrentVC() -> UIViewController? {
        return ch_base_viewGetcurrentVC()
    }
    
    ///view转图片
    func ch_viewToImage() -> UIImage {
        return ch_base_viewToImage()
    }
    
    /// 点击手势(默认代理和target相同)
    func ch_tapGesture(_ target: Any?,_ action: Selector,_ numberOfTapsRequired: Int = 1) {
        ch_base_tapGesture(target, action, numberOfTapsRequired)
    }
    
    /// 长按手势(默认代理和target相同)
    func ch_longGesture(_ target: Any?,_ action: Selector,_ minDuration: TimeInterval = 0.5) {
        ch_base_longGesture(target, action, minDuration)
    }
    
    /// 部分圆角
    func ch_partOfRadius(_ corners: UIRectCorner,_ radius: CGFloat) {
        ch_base_partOfRadius(corners, radius)
    }
    
    /// 截图(带导航则用导航控制器的view或keywindow)
    func ch_screenshotImage() -> UIImage? {
        return ch_base_screenshotImage()
    }

}

public extension UIView {
    
    var height:CGFloat {
        get {
            return frame.height
        }
        set(newValue){
            var tempFrame = self.frame
            tempFrame.size.height = newValue
            self.frame = tempFrame
        }
    }
    
    var width:CGFloat {
        get{
            return frame.width
        }
        
        set(newValue){
            var tempFrame = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    var x:CGFloat {
        get{
            return frame.origin.x
        }
        set(newValue){
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    var centerX:CGFloat {
        get{
            return center.x
        }
        set(newValue){
            var tempCenter = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    var centerY:CGFloat {
        get{
            return center.y
        }
        set(newValue){
            var tempCenter = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    var y:CGFloat {
        get{
            return frame.origin.y
        }
        set(newValue){
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    /// left值
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    /// top值
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    /// right值
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            var tempFrame = frame
            tempFrame.origin.x = newValue - frame.size.width
            frame = tempFrame
        }
    }
    
    /// bottom值
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            var tempFrame = frame
            tempFrame.origin.y = newValue - frame.size.height
            frame = tempFrame
        }
    }
    
    /// size值
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            var tempFrame = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// origin值
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            var tempFrame = frame
            tempFrame.origin = newValue
            frame = tempFrame
        }
    }
}
//MARK: --- 创建View

fileprivate extension UIView {
    
    class func ch_base_view(_ backgroundColor: UIColor) -> Self {
        let view = self.init()
        view.backgroundColor = backgroundColor
        return view
    }
    
    class func ch_base_view(_ backgroundColor: UIColor, _ cornerRadius: CGFloat) -> Self {
        let view = ch_base_view(backgroundColor)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
        return view
    }
    
    func ch_base_view(_ backgroundColor: UIColor, _ cornerRadius: CGFloat)  {
        self.backgroundColor = backgroundColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
//MARK: --- 常用的方法

fileprivate extension UIView {
    
    /// 点击手势(默认代理和target相同)
    func ch_base_tapGesture(_ target: Any?,_ action: Selector,_ numberOfTapsRequired: Int = 1) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = numberOfTapsRequired
        tapGesture.delegate = target as? UIGestureRecognizerDelegate
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    /// 长按手势(默认代理和target相同)
    func ch_base_longGesture(_ target: Any?,_ action: Selector,_ minDuration: TimeInterval = 0.5) {
        let longGesture = UILongPressGestureRecognizer(target: target, action: action)
        longGesture.minimumPressDuration = minDuration
        longGesture.delegate = target as? UIGestureRecognizerDelegate
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(longGesture)
    }
    
    /// 部分圆角
    func ch_base_partOfRadius(_ corners: UIRectCorner,_ radius: CGFloat) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = shapeLayer
    }
    
    /// 截图(带导航则用导航控制器的view或keywindow)
    func ch_base_screenshotImage() -> UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        if self.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        } else if self.layer.responds(to: #selector(CALayer.render(in:) )) {
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
        } else {
            return nil
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    ///设置圆角或者边框
    func ch_base_borderRadius(_ cornerRadius: CGFloat, _ masksToBounds: Bool, _ borderColor:UIColor = .clear, _ borderWidth: CGFloat = 0.0)  {
        self.layer.masksToBounds = masksToBounds
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    /// 水平渐变
    func ch_base_horizontalGradientLayer(_ startColor: UIColor, _ endColor: UIColor, _ cornerRadius:CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    /// 垂直渐变
    func ch_base_verticalGradientLayer(_ startColor: UIColor, _ endColor: UIColor, _ cornerRadius:CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func ch_base_roundingCorner(_ corners: UIRectCorner, _ radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    ///给View添加阴影
    func ch_base_shadow( _ shadowColor:UIColor, _ shadowOffset:CGSize, _ shadowOpacity:Float, _ shadowRadius:CGFloat, _ cornerRadius:CGFloat) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.cornerRadius = cornerRadius
    }
    
    ///给View添加阴影和边框
    func ch_base_shadowBorder( _ shadowColor:UIColor, _ shadowOffset:CGSize, _ shadowOpacity:Float, _ shadowRadius:CGFloat, _ cornerRadius:CGFloat, _ borderColor: UIColor) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
    }
    
    ///获取当前View的控制器
    func ch_base_viewGetcurrentVC() -> UIViewController? {
        var nextResponder: UIResponder? = self
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        } while nextResponder != nil
        
        return nil
    }
    
    func ch_base_viewToImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
    var controller: UIViewController? {
        get {
            var nextResponder: UIResponder?
            nextResponder = next
            repeat {
                if nextResponder is UIViewController {
                    return (nextResponder as! UIViewController)
                } else {
                    nextResponder = nextResponder?.next
                }
            } while nextResponder != nil
            return nil
        }
    }
}
