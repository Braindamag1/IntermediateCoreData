//
//  ShadowHelper.swift
//  EPUI2.0
//
//  Created by YJ.Lee on 2022/4/21.
//

import UIKit

extension UIView {
    func layoutShadow(with shadowColor: UIColor = .black.withAlphaComponent(0.3),
                      shadowRadius: CGFloat = 10,
                      shadowOpacity: Float = 1,
                      shadowOffset:CGSize = .init(width: 0, height: 0),
                      corners:UIRectCorner = [.allCorners]) {
        layer.shadowPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: .init(width: layer.cornerRadius, height: layer.cornerRadius)).cgPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
    }
    
}
