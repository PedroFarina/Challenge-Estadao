//
//  LabelExtension.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import UIKit

internal extension UILabel {
    static func makeViewCodeLabel(with fontstyle: UIFont.TextStyle) -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: fontstyle)
        return label
    }
}
