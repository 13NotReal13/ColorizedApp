//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Иван Семикин on 25/02/2024.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - Public properties
    unowned var delegate: SettingsViewControllerDelegate!
    var viewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = viewColor
        
        setValueForSliders(redSlider, greenSlider, blueSlider)
        setValueForLabels(redLabel, greenLabel, blueLabel)
        setValueForTextFields(redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func slidersAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValueForLabels(redLabel)
            setValueForTextFields(redTextField)
        case greenSlider:
            setValueForLabels(greenLabel)
            setValueForTextFields(greenTextField)
        default:
            setValueForLabels(blueLabel)
            setValueForTextFields(blueTextField)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonAction() {
        delegate.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
}

// MARK: - Private Methods
private extension SettingsViewController {
    func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    func setValueForSliders(_ sliders: UISlider...) {
        let ciColor = CIColor(color: viewColor)
        
        sliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(ciColor.red)
            case greenSlider: greenSlider.value = Float(ciColor.green)
            default:blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    func setValueForLabels(_ labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    func setValueForTextFields(_ textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redSlider)
            case greenTextField: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "Invalid value!",
            message: "Please, enter valid value.",
            preferredStyle: .alert
        )
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}
