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

    private let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        return textField
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = vitamin == nil ? "Add Vitamin" : "Edit Vitamin"

        setupUI()
        fillFormIfEditing()
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, descriptionTextField, optimalTimeTextField, dosageTextField, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView .trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }

    private func fillFormIfEditing() {
        if let vitamin = vitamin {
            nameTextField.text = vitamin.name
            descriptionTextField.text = vitamin.description
            optimalTimeTextField.text = vitamin.optimalTime
            dosageTextField.text = vitamin.dosage
        }
    }

    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty,
              let optimalTime = optimalTimeTextField.text, !optimalTime.isEmpty,
              let dosage = dosageTextField.text, !dosage.isEmpty
        else {
            let alertController = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
            return
        }

        let newVitamin = Vitamin(name: name, description: description, optimalTime: optimalTime, dosage: dosage)
        onSave?(newVitamin)
        navigationController?.popViewController(animated: true)
    }
}
