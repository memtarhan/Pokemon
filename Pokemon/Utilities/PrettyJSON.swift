//
//  PrettyJSON.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation

extension Data {
    private var prettyJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .withoutEscapingSlashes]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
    
    func printPrettied() {
        print(prettyJSON ?? "None")
    }
}
