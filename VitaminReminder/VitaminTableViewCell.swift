import UIKit


protocol VitaminCellDelegate: AnyObject {
    func vitaminCell(_ cell: VitaminTableViewCell, didUpdateSwitchState isOn: Bool)
    func vitaminCell(_ cell: VitaminTableViewCell, didUpdateDatePicker date: Date)
}

class VitaminTableViewCell: UITableViewCell {

    static let reuseIdentifier = "VitaminTableViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        return label
    }()

    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        return picker
    }()

    weak var delegate: VitaminCellDelegate?

    private var reminderSwitch: UISwitch!

    let reminderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set Reminder", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let reminderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()


    private let optimalTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func reminderSwitchToggled(_ sender: UISwitch) {
        delegate?.vitaminCell(self, didUpdateSwitchState: sender.isOn)
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        delegate?.vitaminCell(self, didUpdateDatePicker: sender.date)
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, optimalTimeLabel])
        stackView.axis = .vertical
        stackView.spacing = 4

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let backgroundView = UIView ()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 8
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        contentView.addSubview(backgroundView)
        contentView.sendSubviewToBack(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        reminderSwitch = UISwitch()
        reminderSwitch.translatesAutoresizingMaskIntoConstraints = false
        reminderSwitch.addTarget(self, action: #selector(reminderSwitchToggled(_:)), for: .valueChanged)
        contentView.addSubview(reminderSwitch)
        contentView.addSubview(reminderLabel)
        contentView.addSubview(datePicker)

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            reminderSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            reminderSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            reminderLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            reminderLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            datePicker.topAnchor.constraint(equalTo: reminderSwitch.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }

    func configure(with vitamin: Vitamin) {
        nameLabel.text = vitamin.name
        optimalTimeLabel.text = "Optimal Time: \(vitamin.optimalTime)"
        reminderLabel.text = vitamin.hasReminder ? "Reminder set" : "No reminder"
    }
}

