//
//  FavoriteLeaguesTableViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import UIKit

class FavoriteLeaguesViewController: UIViewController {

    @IBOutlet weak var myFavoriteLeaguesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomLeaguesTableViewCell", bundle: nil)
        myFavoriteLeaguesTableView.register(nib, forCellReuseIdentifier: "cell")

    }

}

extension FavoriteLeaguesViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myFavoriteLeaguesTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomLeaguesTableViewCell
        
        return cell
        
    }
    
    
}
