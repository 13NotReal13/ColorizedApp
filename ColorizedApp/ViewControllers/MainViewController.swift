//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Иван Семикин on 25/02/2024.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as? SettingsViewController
        settingsVC?.delegate = self
        settingsVC?.viewColor = view.backgroundColor
    }

}

extension MainViewController: SettingsViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
