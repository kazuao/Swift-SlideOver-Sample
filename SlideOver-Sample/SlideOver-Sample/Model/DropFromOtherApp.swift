//
//  DropFromOtherApp.swift
//  SlideOver-Sample
//
//  Created by k-aoki on 2021/09/17.
//

import Foundation
import MobileCoreServices

class DropFromOtherApp: NSObject, NSItemProviderReading {
    let data: Data?

    required init(modelData: Data, typeIdentifier: String) {
        data = modelData
    }

    static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeContent as String]
    }

    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        return self.init(modelData: data, typeIdentifier: typeIdentifier)
    }
}
