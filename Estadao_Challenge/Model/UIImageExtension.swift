//
//  UIImageExtension.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 02/03/21.
//

import UIKit

internal extension UIImage {
    func processImage(toWidth width: CGFloat) -> UIImage? {
        let newSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))

        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        draw(in: CGRect(origin: .zero, size: newSize))
        defer {
            UIGraphicsEndImageContext()
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
