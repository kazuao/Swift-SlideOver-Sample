//
//  ViewController+Drag.swift
//  SlideOver-Sample
//
//  Created by k-aoki on 2021/09/17.
//

import UIKit

// このアプリから、他のアプリにドラッグする時の処理
// MARK: - UITableViewDragDelegate
extension ViewController: UITableViewDragDelegate {

    // ドラッグするアイテムの初期設定
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {

        // MEMO: ドラッグしたファイルを送りたくない場合は、空の配列を返す

        return model.dragItems(for: indexPath)
    }

    // ドラッグ開始したら
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    // ドラッグ終わったら
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

