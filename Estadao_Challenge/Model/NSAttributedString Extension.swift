//
//  NSAttributedString Extension.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 02/03/21.
//

import Foundation
import UIKit

internal extension NSAttributedString {
    func fitImagesToScreenSize(maxWidth: CGFloat) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(attributedString: self)
        mutableString.enumerateAttribute(NSAttributedString.Key.attachment, in: .init(location: 0, length: mutableString.length), options: .longestEffectiveRangeNotRequired) { (value, range, _) in
            if let attachement = value as? NSTextAttachment {
                let image = attachement.image(forBounds: attachement.bounds, textContainer: NSTextContainer(), characterIndex: range.location)!
                if image.size.width > maxWidth {
                    let newImage: UIImage? = image.processImage(toWidth: maxWidth)
                    let newAttribut = NSTextAttachment()
                    newAttribut.image = newImage
                    mutableString.addAttribute(NSAttributedString.Key.attachment, value: newAttribut, range: range)
                }
            }
        }

        return mutableString
    }
}
