//
//  BattlefieldViewController.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

class BattlefieldViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var winnerBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    var viewModel: BattlefieldVM?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BattlefieldVM(delegate: self)
        setBackgroundImage(.warBackground)
    }

    // MARK: - Button Actions
    @IBAction func winnerBtnAction(_ sender: UIButton) {
        guard let viewController = UIStoryboard.init(name: Storyborad.storyboardUsed(for: .main),
                                                     bundle: Bundle.main).instantiateViewController(withIdentifier:
            ResultViewController.className) as? ResultViewController else {
            return
        }
        viewController.viewModel = ResultVM(battleModel: viewModel?.battleModel ?? [])
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - TableView Delegate and DataSource
extension BattlefieldViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.battleModel.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(
                withType: BattlefieldTableCell.self, for: indexPath) as? BattlefieldTableCell
        else { return UITableViewCell() }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.transformer = viewModel?.battleModel[indexPath.row]

        return cell
    }

}

// MARK: - Custom Delegates
extension BattlefieldViewController: BattlefieldVMDelegate {
    func userListApiDidFinish(success: Bool, message: String?) {
        self.tableView.setEmptyView(with: !success, message: message ?? AppStrings.Alert.noData)
        self.tableView.reloadData()
    }

}
