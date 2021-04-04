//
//  PostsViewController.swift
//  LibertySolutionDemo
//
//  Created by Ashish Viltoriya on 03/04/21.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = PostsViewModel()
    var posts: [Posts]?
    let indicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startActivityIndicator()
        viewModel.getPosts()
        viewModel.postsData.bind {[weak self] (posts) in
            self?.posts = posts
            self?.tableView.reloadData()
            self?.stopActivityIndicator()
        }
        
        viewModel.dataError.bind {[weak self] (error) in
            if error {
                self?.showAlertDialog(title: "Error", message: "Couldn't found data")
            }
        }
    }
    
    private func startActivityIndicator() {
        indicator.center = self.view.center
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        tableView.isHidden = true
        self.view.addSubview(indicator)
    }
    
    private func stopActivityIndicator() {
        tableView.isHidden = false
        indicator.stopAnimating()
    }
    
    func showAlertDialog(title: String, message: String) {
        let alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertDialog.addAction(.init(title: "Ok", style: .default, handler: nil))
        present(alertDialog, animated: true, completion: nil)
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = posts?[indexPath.row].title
        cell.detailTextLabel?.text = posts?[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        posts?[indexPath.row].isFavourite = true
        showAlertDialog(title: "Alert", message: "Successfully Added Favourite")
    }
    
}
