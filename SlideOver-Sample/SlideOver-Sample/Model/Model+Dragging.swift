//
//  Model+Dragging.swift
//  SlideOver-Sample
//
//  Created by k-aoki on 2021/09/17.
//

import UIKit
import MobileCoreServices

extension Model {

    // NSStringに準拠している型のみドロップを許可する
    func canHandle(_ session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }

    // ドラッグするitemの送信用に変換
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let placeName = placeNames[indexPath.row]

        let data = placeName.data(using: .utf8)

        let itemProvider = NSItemProvider()
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(data, nil)
            return nil
        }

        return [UIDragItem(itemProvider: itemProvider)]
    }
}
