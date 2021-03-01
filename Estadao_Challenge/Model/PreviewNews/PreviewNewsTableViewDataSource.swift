//
//  PreviewNewsTableViewDataSource.swift
//  Estadao_Challenge
//
//  Created by Pedro Giuliano Farina on 28/02/21.
//

import UIKit

internal class PreviewNewsTableViewDataSource: NSObject, UITableViewDataSource {
    private let data: [PreviewNews]
    internal init(news data: [PreviewNews]) {
        self.data = data
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = PreviewNewsTableViewCell(news: data[indexPath.row])
        return newsCell
    }
}
