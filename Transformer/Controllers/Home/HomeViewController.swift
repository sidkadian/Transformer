//
//  HomeViewController.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: - UI Elements
    @IBOutlet weak var createListBtn: UIButton!
    @IBOutlet weak var battlefiledBtn: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
    }

    // MARK: - Button Actions
    @IBAction func createListBtnAction(_ sender: UIButton) {
        moveToCybertron()
    }

    @IBAction func battlefieldBtnAction(_ sender: UIButton) {
        moveToBattlefield()
    }

    // MARK: - Private functions
    private func moveToCybertron() {
        guard let viewController = UIStoryboard.init(name: Storyborad.storyboardUsed(for: .main),
                                                     bundle: Bundle.main).instantiateViewController(
                                                        withIdentifier:
                                                            CybertronListViewController.className)
                as? CybertronListViewController
        else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    private func moveToBattlefield() {
        guard let viewController = UIStoryboard.init(name: Storyborad.storyboardUsed(for: .main),
                                                     bundle: Bundle.main).instantiateViewController(
                                                        withIdentifier:
            BattlefieldViewController.className) as? BattlefieldViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
