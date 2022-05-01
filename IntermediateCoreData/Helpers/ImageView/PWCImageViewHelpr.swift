//
//  PWCImageViewHelpr.swift
//  EPUI2.0
//
//  Created by YJ.Lee on 2022/4/24.
//

import UIKit
extension UIImageView {
    
    // 360度旋转图片
    func rotate360Degree() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0) // 旋转角度
        rotationAnimation.duration = 0.6 // 旋转周期
        rotationAnimation.isCumulative = true // 旋转累加角度
        rotationAnimation.repeatCount = 100000 // 旋转次数
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    // 停止旋转
    func stopRotate() {
        layer.removeAllAnimations()
    }
}
