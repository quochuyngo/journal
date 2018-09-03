//
//  TimelineViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/23/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import GooglePlaces
import RealmSwift

let realm = try! Realm()

class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let locationManager: CLLocationManager = CLLocationManager()
    var journalList = [Journal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        journalList = getListJournal()
        setupTableView()
        if let customTabBar = tabBarController?.tabBar as? CustomTabBar {
            customTabBar.customDelegate = self
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)
        tableView.register(UINib(nibName: String(describing: JournalCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JournalCell.self))
    }

    func getListJournal() -> [Journal]{
        let journalList = realm.objects(Journal.self)
        return Array(journalList).reversed()
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JournalCell.self)) as! JournalCell
        cell.data = journalList[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 360
//    }
    
}
extension TimelineViewController: CustomBarDelegate {
    func tabBar(_ tabBar: UITabBar, didTapCenterButton: UIButton) {
        let nav = StoryboardManager.Main.getNewPostVC()
        if let vc = nav.viewControllers.first as? NewJournalViewController {
            vc.delegate = self
        }
        present(nav, animated: true, completion: nil)
    }
}

extension TimelineViewController: NewJournalViewControllerDelegate {
    func didAdd(_ journal: Journal) {
        journalList.append(journal)
        tableView.reloadData()
        try! realm.write {
            realm.add(journal)
        }
    }
}
