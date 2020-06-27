//
//  CastListVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 27.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class CastListVC: UIViewController {
    let tableView           = UITableView()
    var casts: [MovieCast]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Casts"
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(CastCell.self, forCellReuseIdentifier: CastCell.reuseID)
    }
}

extension CastListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.reuseID) as! CastCell
        let cast = casts[indexPath.row]
        
        cell.selectionStyle = .none
        cell.set(cast: cast)
        
        return cell
    }
    
    
}
