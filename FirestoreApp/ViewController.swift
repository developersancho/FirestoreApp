//
//  ViewController.swift
//  FirestoreApp
//
//  Created by developersancho on 16.10.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    var db: Firestore!
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        FirestoreService.shared.read(from: .users, returning: User.self) { (users) in
            self.users = users
            self.tableView.reloadData()
        }
    }
    @IBAction func onAddTapped(_ sender: Any) {
        AlertService.addUser(in: self) { user in
            FirestoreService.shared.create(for: user, in: .users)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = String(user.age)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        AlertService.update(user, in: self) { (updatedUser) in
            FirestoreService.shared.update(for: updatedUser, in: .users)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let user = users[indexPath.row]
        FirestoreService.shared.delete(user, in: .users)
    }
    
}

