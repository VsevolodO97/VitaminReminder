import UIKit

class VitaminTableViewCell: UITableViewCell {

    static let reuseIdentifier = "VitaminTableViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
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

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with vitamin: Vitamin) {
        nameLabel.text = vitamin.name
        optimalTimeLabel.text = "Optimal Time: \(vitamin.optimalTime)"
    }
}

