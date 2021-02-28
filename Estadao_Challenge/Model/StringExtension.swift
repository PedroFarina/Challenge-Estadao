//
//  StringExtension.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import Foundation

extension String {
    func toHTML() -> NSAttributedString {
        if let data = data(using: .utf8),
           let htmlString = try? NSAttributedString(data: data,
                                                 options: [
                                                    .documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue
                                                 ],
                                                 documentAttributes: nil){
            return htmlString
        }
        return NSAttributedString(string: self)
    }
}
