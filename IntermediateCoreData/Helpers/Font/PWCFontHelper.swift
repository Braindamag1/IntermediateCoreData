//
//  PWCFontHelper.swift
//  EP UI
//
//  Created by YJ.Lee on 2022/3/22.
//

import Foundation
import UIKit
extension UIFont {
    public static func printFontsFamilyName() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) FontNames: \(names)")
        }
    }

    // MARK: - 苹方

    /// 苹方常规体
    public static func pingFangRegular(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// 苹方中黑体
    public static func pingFangMedium(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// 苹方中粗体
    public static func pingFangSemibold(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Semibold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// 苹方细体
    public static func pingFangSCLight(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Light", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    // MARK: - Roboto

    /// Roboto常规
    public static func robotoRegular(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// Roboto中黑体
    public static func robotoMedium(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// Roboto中粗体
    public static func robotoSemibold(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Semibold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// Reboto 细体
    public static func robotoLight(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Light", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    // MARK: - Montserrat Alternates

    /// Montserrat Alternates 细体
    public static func MontserratAlternatesLight(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MontserratAlternates-Light", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// Montserrat Alternates 常规体
    public static func MontserratAlternatesRegular(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MontserratAlternates-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// Montserrat Alternates 中黑体
    public static func MontserratAlternatesMedium(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MontserratAlternates-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// Montserrat Alternates 中粗体
    public static func MontserratAlternatesSemibold(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MontserratAlternates-Semibold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// Montserrat Alternates 粗体
    public static func MontserratAlternatesBold(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MontserratAlternates-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    /// Montserrat Alternates 黑体
    public static func MontserratAlternatesBlack(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MontserratAlternates-Black", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    public static func MontserratAlternatesThin(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MontserratAlternates-Thin", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
