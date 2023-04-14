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
    }

    private func setupVitaminDetails() {
        vitaminInfoTextView.text = """
        Description: \(vitamin.description)
        Optimal Time: \(vitamin.optimalTime)
        Dosage: \(vitamin.dosage)
        """

        view.addSubview(vitaminInfoTextView)

        vitaminInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vitaminInfoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vitaminInfoTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vitaminInfoTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            vitaminInfoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        // Add this line to force the layout to update.
        view.layoutIfNeeded()
    }
}

