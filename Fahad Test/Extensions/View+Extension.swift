//
//  UITableView+Entension.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//


import Foundation
import UIKit

extension UIView {
    func roundCorners(cornerRadius: Double = 0.0, borderWidth: CGFloat = 0.0, borderColor: UIColor = .clear, clipToBounds: Bool = true) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = clipToBounds
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func dropShadow(radius: CGFloat, color: UIColor, opacity: Float, offset: CGSize = .zero, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func roundTop(radius: CGFloat = 7) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundBottom(radius: CGFloat = 7) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundRightCorners(radius: CGFloat = 7) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundReftCorners(radius: CGFloat = 7) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addShadowAndCornerRadius(cornerRadius: CGFloat = 0) {
        let roundCorners = cornerRadius == 0 ? self.frame.size.width/2 : cornerRadius
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: roundCorners).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func addShadowAndRadiustoButton(cornerRadius: CGFloat, opacity: Float = 0.1) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = 7
    }
    
    func addDashedBorder(cornerRadius: CGFloat, lineWidth: CGFloat, borderColor: UIColor) {
        let color = borderColor.cgColor

        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath

        self.layer.addSublayer(shapeLayer)
        }
    /**
    Fade out a view with a duration 1.0 & Curve Ease In Animation
    
    - parameter duration: custom animation duration
    */
    func fadeInWithAnimation() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    /**
    Fade out a view with a duration 1.0 & Curve Ease Out Animation
    
    - parameter duration: custom animation duration
    */
    func fadeOutWithAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    
    // there can be other views between `subview` and `self`
    func getConvertedFrame(fromSubview subview: UIView) -> CGRect? {
        // check if `subview` is a subview of self
        guard subview.isDescendant(of: self) else {
            return nil
        }
        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }
        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            if superview!.superview == nil {
                break
            } else {
                superview = superview!.superview
            }
        }
        return superview!.convert(frame, to: self)
    }
    
    var fullScreenAnimationDuration: TimeInterval {
        return 0.15
    }

    func minimizeToFrame(_ frame: CGRect) {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.transform = .identity
            self.frame = frame
        }
    }
    
    // MARK: - Easy Frames
    
    var frameX: CGFloat { get {return frame.origin.x} set { frame.origin.x = newValue} }
    var frameY: CGFloat { get {return frame.origin.y} set { frame.origin.y = newValue} }
    var frameWidth: CGFloat { get {return frame.width} set { frame.size.width = newValue} }
    var frameHeight: CGFloat { get {return frame.height} set {frame.size.height = newValue} }

    
    // MARK: - Cornar Radius
    
    func setCornarRadius(_ cornarRadius: CGFloat, cornars: UIRectCorner, strokeColor: UIColor?) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornars, cornerRadii: CGSize(width: cornarRadius, height: cornarRadius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        if (strokeColor != nil) { maskLayer.strokeColor = strokeColor?.cgColor}
        maskLayer.path = maskPath.cgPath
        
        // Set the newly created shape layer as the mask for the image view's layer
        layer.mask = maskLayer
        
    }
    
    // MARK: - Utility
    
    func removeAllSubviews() {
        self.subviews.forEach{ $0.removeFromSuperview() }
    }
    
    @discardableResult func addTapGestureRecognizer(target: Any?, action: Selector?, cancelsTouchesInView: Bool = true) -> UITapGestureRecognizer {
        
        isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        tapGestureRecognizer.cancelsTouchesInView = cancelsTouchesInView
        addGestureRecognizer(tapGestureRecognizer)
        return tapGestureRecognizer
    }
    
    @discardableResult func addLongPressGestureRecognizer(target: Any?, action: Selector?, minimumPressDuration: CFTimeInterval = 1.0) -> UILongPressGestureRecognizer {
        
        isUserInteractionEnabled = true
        let longPressGesture = UILongPressGestureRecognizer(target: target, action: action)
        longPressGesture.minimumPressDuration = minimumPressDuration
        addGestureRecognizer(longPressGesture)
        return longPressGesture
    }

    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }

    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }

    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(_ duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(_ duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     get screenShot of view as image
    
     */
    
    func asImage() -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}



extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
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
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
}

@IBDesignable extension UIView {
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    @IBInspectable var shadowOpacity: CGFloat {
        get { return CGFloat(layer.shadowOpacity) }
        set { layer.shadowOpacity = Float(newValue) }
    }

    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
}
