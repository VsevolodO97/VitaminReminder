import UIKit

class AddEditVitaminViewController: UIViewController {

    var vitamin: Vitamin?
    var onSave: ((Vitamin) -> Void)?

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Vitamin Name"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = true
        return textView
    }()


    private let optimalTimeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Optimal Time"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let dosageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Dosage"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    private let reminderSwitch: UISwitch = {
        let reminderSwitch = UISwitch()
        reminderSwitch.isOn = false
        return reminderSwitch
    }()

    private let reminderDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.isHidden = true
        return datePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = vitamin == nil ? "Add Vitamin" : "Edit Vitamin"

        setupUI()
        fillFormIfEditing()
    }


    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, descriptionTextView, optimalTimeTextField, dosageTextField, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true // Add this line
    }


    private func fillFormIfEditing() {
        if let vitamin = vitamin {
            nameTextField.text = vitamin.name
            descriptionTextView.text = vitamin.description
            optimalTimeTextField.text = vitamin.optimalTime
            dosageTextField.text = vitamin.dosage
        }
    }

    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty,
              let optimalTime = optimalTimeTextField.text, !optimalTime.isEmpty,
              let dosage = dosageTextField.text, !dosage.isEmpty
        else {
            let alertController = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
            return
        }

        let newVitamin = Vitamin(name: name, description: description, optimalTime: optimalTime, dosage: dosage, hasReminder: reminderSwitch.isOn)
        onSave?(newVitamin)
        navigationController?.popViewController(animated: true)

        // Schedule or cancel the reminder
        if reminderSwitch.isOn {
            let reminder = Reminder(id: UUID(), vitamin: newVitamin, date: reminderDatePicker.date)
        }
    }
}
