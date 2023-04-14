import UIKit
import UserNotifications

class VitaminSelectionViewController: UITableViewController, VitaminCellDelegate {

    var didSelectVitamin: ((Vitamin) -> Void)?

    // Predefined list of vitamins
    var vitamins: [Vitamin] = [
        Vitamin(name: "Vitamin A", description: "Promotes healthy vision, skin, and immune system", optimalTime: "Morning with breakfast", dosage: "Men: 900 mcg, Women: 700 mcg", hasReminder: false, remindTime: nil),
        Vitamin(name: "Vitamin C", description: "Boosts immune system, helps with iron absorption, promotes skin health", optimalTime: "Anytime of day", dosage: "Men: 90 mg, Women: 75 mg", hasReminder: false, remindTime: nil),
        Vitamin(name: "Vitamin D", description: "Helps with bone health, immune system, and mood regulation", optimalTime: "Morning with breakfast", dosage: "Men and Women: 10-20 mcg", hasReminder: false, remindTime: nil),
        Vitamin(name: "Vitamin E", description: "Promotes skin health, acts as an antioxidant", optimalTime: "Anytime of day", dosage: "Men and Women: 15 mg", hasReminder: false, remindTime: nil),
        Vitamin(name: "Vitamin B12", description: "Helps with energy production, promotes healthy nerve and blood cells", optimalTime: "Morning with breakfast", dosage: "Men and Women: 2.4 mcg", hasReminder: false, remindTime: nil),
        Vitamin(name: "Vitamin B6", description: "Helps with energy production, promotes healthy brain function and mood regulation", optimalTime: "Anytime of day", dosage: "Men: 1.3-1.7 mg, Women: 1.2-1.5 mg", hasReminder: false, remindTime: nil),
        Vitamin(name: "Folic Acid", description: "Promotes healthy brain function and red blood cell production, reduces risk of birth defects during pregnancy", optimalTime: "Morning with breakfast", dosage: "Men and Women: 400 mcg", hasReminder: false, remindTime: nil),
        Vitamin(name: "Calcium", description: "Promotes healthy bones and teeth, helps with muscle and nerve function", optimalTime: "Anytime of day", dosage: "Men: 1000 mg, Women: 1000-1200 mg", hasReminder: false, remindTime: nil),
        Vitamin(name: "Iron", description: "Helps with red blood cell production, promotes healthy immune system", optimalTime: "Morning with breakfast", dosage: "Men: 8 mg, Women: 18 mg (19-50 years), 8 mg (51+ years)", hasReminder: false, remindTime: nil),
        Vitamin(name: "Magnesium", description: "Helps with muscle and nerve function, promotes healthy heart rhythm and bone health", optimalTime: "Anytime of day", dosage: "Men: 400-420 mg, Women: 310-320 mg", hasReminder: false, remindTime: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Select Vitamins"
        tableView.register(VitaminTableViewCell.self, forCellReuseIdentifier: "VitaminCell")

        addDisclaimer()
        ReminderManager.shared.requestNotificationAuthorization()
    }
    func vitaminCell(_ cell: VitaminTableViewCell, didUpdateSwitchState isOn: Bool) {
        // Handle the reminder switch value change here
    }

    func vitaminCell(_ cell: VitaminTableViewCell, didUpdateDatePicker date: Date) {
        // Handle the reminder date change here
    }

    func addDisclaimer() {
        // Add a footer view with a disclaimer
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        let disclaimerLabel = UILabel()
        disclaimerLabel.text = "Information about each vitamin is not a medical advice. Please consult with a healthcare professional before starting any supplement regimen."
        disclaimerLabel.numberOfLines = 0
        disclaimerLabel.font = UIFont.systemFont(ofSize: 12)
        disclaimerLabel.textColor = .darkGray
        disclaimerLabel.textAlignment = .center

        footerView.addSubview(disclaimerLabel)
        disclaimerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            disclaimerLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            disclaimerLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            disclaimerLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])

        tableView.tableFooterView = footerView
    }

        @objc func handleReminderSwitchChanged(_ sender: UISwitch) {
            let index = sender.tag
            vitamins[index].hasReminder = sender.isOn
        }

        @objc func handleDatePickerValueChanged(_ sender: UIDatePicker) {
            let index = sender.tag
            vitamins[index].remindTime = sender.date
        }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vitamins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VitaminCell", for: indexPath) as! VitaminTableViewCell
        let vitamin = vitamins[indexPath.row]
        cell.configure(with: vitamin)
        cell.delegate = self
        cell.reminderButton.tag = indexPath.row
        cell.reminderButton.addTarget(self, action: #selector(handleReminderSwitchChanged(_:)), for: .touchUpInside)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVitamin = vitamins[indexPath.row]
        didSelectVitamin?(selectedVitamin)
        navigationController?.popViewController(animated: true)
    }

    private func scheduleReminder(for vitamin: Vitamin) {
        guard let reminderTime = vitamin.remindTime else { return }

        let content = UNMutableNotificationContent()
        content.title = "Vitamin Reminder"
        content.body = "Time to take your \(vitamin.name) vitamin."
        content.sound = .default

        let components = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(identifier: "VitaminReminder-\(vitamin.name)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Notification scheduled for \(vitamin.name) at \(reminderTime)")
            }
        }
    }


    @objc private func showDatePicker(_ sender: UIButton) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(handleDatePickerValueChanged(_:)), for: .valueChanged)

        let alertController = UIAlertController(title: "Set Reminder", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alertController.view.addSubview(datePicker)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let indexPath = self.tableView.indexPathForSelectedRow {
                var vitamin = self.vitamins[indexPath.row]
                vitamin.hasReminder = true
                vitamin.remindTime = datePicker.date
                self.scheduleReminder(for: vitamin)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    @objc private func datePickerChanged(_ datePicker: UIDatePicker) {
        // Update the selected vitamin's reminder time
    }

}

