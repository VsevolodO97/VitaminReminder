import UIKit

class VitaminSelectionViewController: UITableViewController {

    var didSelectVitamin: ((Vitamin) -> Void)?

    // Predefined list of vitamins
    let vitamins: [Vitamin] = [
        Vitamin(name: "Vitamin A", description: "Promotes healthy vision, skin, and immune system", optimalTime: "Morning with breakfast", dosage: "Men: 900 mcg, Women: 700 mcg"),
        Vitamin(name: "Vitamin C", description: "Boosts immune system, helps with iron absorption, promotes skin health", optimalTime: "Anytime of day", dosage: "Men: 90 mg, Women: 75 mg"),
        Vitamin(name: "Vitamin D", description: "Helps with bone health, immune system, and mood regulation", optimalTime: "Morning with breakfast", dosage: "Men and Women: 10-20 mcg"),
        Vitamin(name: "Vitamin E", description: "Promotes skin health, acts as an antioxidant", optimalTime: "Anytime of day", dosage: "Men and Women: 15 mg"),
        Vitamin(name: "Vitamin B12", description: "Helps with energy production, promotes healthy nerve and blood cells", optimalTime: "Morning with breakfast", dosage: "Men and Women: 2.4 mcg"),
        Vitamin(name: "Vitamin B6", description: "Helps with energy production, promotes healthy brain function and mood regulation", optimalTime: "Anytime of day", dosage: "Men: 1.3-1.7 mg, Women: 1.2-1.5 mg"),
        Vitamin(name: "Folic Acid", description: "Promotes healthy brain function and red blood cell production, reduces risk of birth defects during pregnancy", optimalTime: "Morning with breakfast", dosage: "Men and Women: 400 mcg"),
        Vitamin(name: "Calcium", description: "Promotes healthy bones and teeth, helps with muscle and nerve function", optimalTime: "Anytime of day", dosage: "Men: 1000 mg, Women: 1000-1200 mg"),
        Vitamin(name: "Iron", description: "Helps with red blood cell production, promotes healthy immune system", optimalTime: "Morning with breakfast", dosage: "Men: 8 mg, Women: 18 mg (19-50 years), 8 mg (51+ years)"),
        Vitamin(name: "Magnesium", description: "Helps with muscle and nerve function, promotes healthy heart rhythm and bone health", optimalTime: "Anytime of day", dosage: "Men: 400-420 mg, Women: 310-320 mg")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Select Vitamins"
        tableView.register(VitaminTableViewCell.self, forCellReuseIdentifier: "VitaminCell")

        addDisclaimer()
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vitamins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VitaminCell", for: indexPath) as! VitaminTableViewCell
        let vitamin = vitamins[indexPath.row]
        cell.configure(with: vitamin)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVitamin = vitamins[indexPath.row]
        didSelectVitamin?(selectedVitamin)
        navigationController?.popViewController(animated: true)
    }
}

