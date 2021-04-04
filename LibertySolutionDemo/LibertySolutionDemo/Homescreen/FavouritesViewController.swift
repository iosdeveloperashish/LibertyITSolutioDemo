//
//  FavouritesViewController.swift
//  LibertySolutionDemo
//
//  Created by Ashish Viltoriya on 03/04/21.
//

import UIKit

class FavouritesViewController: UIViewController {

    var posts = [Posts]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    func getPostsData(with data: [Posts]) {
        posts.removeAll()
        for post in data where post.isFavourite == true {
            self.posts.append(post)
        }
        self.tableView.reloadData()
    }
    
}
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].body
        return cell
    }
}
