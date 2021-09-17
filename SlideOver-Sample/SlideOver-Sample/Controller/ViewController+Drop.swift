//
//  ViewController+Drop.swift
//  SlideOver-Sample
//
//  Created by k-aoki on 2021/09/17.
//

import UIKit

// SplitView/SlideOverなどで、別アプリからドラッグされてきた時の処理
// MARK: - UITableViewDropDelegate
extension ViewController: UITableViewDropDelegate {

    // ドロップされたファイルを受け取るか
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {

        print("*** canHandle ***")
        print("indicotor: \(session.progressIndicatorStyle)") // 進行状態のインジケータ

        return model.canHandle(session)
    }

    // ドロップしたあとの処理
    // https://developer.apple.com/documentation/uikit/uitableviewdropdelegate/2897302-tableview
    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {

        // ドラッグ中、ずっと呼び出されるので、複雑な処理はしない方がいい
        /*
         .cancel: 移動させない
         .forbidden: ドロップを許可しない
         .move: 移動する
         .copy: コピーする
         */

        // 初期値キャンセル
        var dropProposal = UITableViewDropProposal (operation: .cancel)

        // 1つ以外のファイルは受けない
        guard session.items.count == 1 else { return dropProposal }

        if tableView.hasActiveDrag { // drag中か？同じtableView内からのdrag判定
            if tableView.isEditing { // 編集中か
                /*
                 unspecified: ドロップ後は指定されていない
                 insertAtDestinationIndexPath: ドロップしたアイテムを指定したindexPathに挿入する
                 insertIntoDestinationIndexPath: ドロップされたアイテムを指定されたインデックスパスのアイテムに組み込む
                 */
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }

        return dropProposal
    }


    // ドロップされたデータをデータ構造に組み込み、テーブルの更新を行う
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("*** performDropWith ***")

        print(coordinator)
        coordinator.items.forEach({
            print($0.dragItem)
            print($0.sourceIndexPath ?? "")      // これが入っている場合は、画面内のドラッグ
            print($0.dragItem.localObject ?? "") // これがある場合は、アプリ内の別の場所からドラッグ
            print($0.dragItem.itemProvider)      // 非同期で取得するのに使う
        })

        let destinationIndexPath: IndexPath
        /*
         destinationIndexPathがあるのは、
         最後にヒットしたindexPath
         要は、dragした時に、どこかのセルに触っているか
         */
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // ない場合は、最後に挿入する
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }

        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            let stringItems = items as! [String]

            var indexPaths = [IndexPath]()
            for (index, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)

                self.model.addItem(item, at: indexPath.row)
                indexPaths.append(indexPath)
            }

            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}
