import UIKit

class VitaminDetailViewController: UIViewController {

    private let vitamin: Vitamin

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
        let vitaminInfo = UILabel()
        vitaminInfo.numberOfLines = 0
        vitaminInfo.text = """
        Description: \(vitamin.description)
        Optimal Time: \(vitamin.optimalTime)
        Dosage: \(vitamin.dosage)
        """

        view.addSubview(vitaminInfo)

        vitaminInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vitaminInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vitaminInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vitaminInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

