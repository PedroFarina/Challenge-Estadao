//
//  PreviewNewsTableViewDelegate.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 01/03/21.
//

import UIKit

internal protocol PreviewNewsTableViewDelegateObserver: class {
    func didSelectNewsWithID(_ id: String)
}

internal class PreviewNewsTableViewDelegate: NSObject, UITableViewDelegate {

    internal weak var observer: PreviewNewsTableViewDelegateObserver?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PreviewNewsTableViewCell {
            observer?.didSelectNewsWithID(cell.news.id_documento)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
