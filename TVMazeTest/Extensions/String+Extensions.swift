//
//  String+Extensions.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        let str = htmlToAttributedString?.string

        let resultStr = str?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

        return resultStr ?? ""
    }
}
