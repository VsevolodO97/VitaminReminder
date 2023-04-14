import UIKit

class VitaminDetailViewController: UIViewController {

    private let vitamin: Vitamin
    private let vitaminInfoTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = true
        return textView
    }()
    private let reminderSwitch: UISwitch = {
        let reminderSwitch = UISwitch()
        return reminderSwitch
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.isHidden = true
        return datePicker
    }()


    init(vitamin: Vitamin) {
        self.vitamin = vitamin
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = vitamin.name

        setupVitaminDetails()
        reminderSwitch.addTarget(self, action: #selector(reminderSwitchChanged), for: .valueChanged)
    }

    @objc private func reminderSwitchChanged() {
        datePicker.isHidden = !reminderSwitch.isOn

        if reminderSwitch.isOn {
            let selectedDate = datePicker.date
            let reminder = Reminder(id: UUID(), vitamin: vitamin, date: selectedDate)
            ReminderManager.shared.scheduleReminder(reminder: reminder)
        } else {
            ReminderManager.shared.cancelReminder(for: vitamin.name)
        }
    }


    private func setupVitaminDetails() {
        let vitaminInfoTextView = UILabel()
        vitaminInfoTextView.numberOfLines = 0
        vitaminInfoTextView.text = """
        Description: \(vitamin.description)
        Optimal Time: \(vitamin.optimalTime)
        Dosage: \(vitamin.dosage)
        """

        view.addSubview(vitaminInfoTextView)
        view.addSubview(datePicker)

        vitaminInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vitaminInfoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vitaminInfoTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vitaminInfoTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            vitaminInfoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            datePicker.topAnchor.constraint(equalTo: vitaminInfoTextView.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        // Add this line to force the layout to update.
        view.layoutIfNeeded()
    }
}

