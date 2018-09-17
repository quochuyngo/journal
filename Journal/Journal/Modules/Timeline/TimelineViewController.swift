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

class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var locationManager: CLLocationManager = CLLocationManager()
    let viewModel: TimelineViewModel = TimelineViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        setupTableView()
        if let customTabBar = tabBarController?.tabBar as? CustomTabBar {
            customTabBar.customDelegate = self
        }
        handleActionSelected()
        
    }
    
    override func didReceiveMemoryWarning() {
        print("Out of memory")
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)
        tableView.register(UINib(nibName: String(describing: JournalCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JournalCell.self))
    }


    
    func handleActionSelected() {
        ActionSheetManager.actionDidSelect = { action in
            switch action {
            case .edit(let journal):
                let nav = StoryboardManager.Main.getNewPostVC()
                if let vc = nav.viewControllers.first as? NewJournalViewController {
                    vc.delegate = self
                    vc.viewModel.editJournal = journal
                }
                self.present(nav, animated: true, completion: nil)
                break
            case .delete(let journal):
                self.present(AlertManager.getAlert(withType: .delete, handler: {
                    result in
                    switch result {
                    case .yes:
                        self.viewModel.delete(journal)
                        self.tableView.reloadData()
                        break
                    default:
                        break
                    }
                }), animated: true, completion: nil)
              
                break
            default:
                break
            }
        }
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.journalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JournalCell.self), for: indexPath) as! JournalCell
        cell.configCell(with: viewModel.journalList[indexPath.row])
        cell.delegate = self
        return cell
    }
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
    func didAddJournal(_ journal: Journal?) {
        tableView.reloadData()
    }
}

extension TimelineViewController: JournalCellDelegate {
    func moreButtonDidTap(_ journal: Journal) {
        present(ActionSheetManager.getActionSheet(withType: .more, journal), animated: true, completion: nil)
    }
}
