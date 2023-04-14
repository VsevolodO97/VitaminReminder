import UIKit

class ViewController: UITableViewController {

    private var vitamins: [Vitamin] = [
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

        // Customize navigation bar appearance
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor.black
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.tintColor = UIColor.white
        title = "Vitamins"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

        tableView.register(VitaminTableViewCell.self, forCellReuseIdentifier: VitaminTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()

        addDisclaimer()
    }

    @objc private func addButtonTapped() {
        let addEditVitaminViewController = AddEditVitaminViewController()
        addEditVitaminViewController.onSave = { [weak self] newVitamin in
            self?.vitamins.append(newVitamin)
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(addEditVitaminViewController, animated: true)
    }

    private func setupTableViewConstraints() {

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vitamins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VitaminTableViewCell.reuseIdentifier, for: indexPath) as! VitaminTableViewCell
        let vitamin = vitamins[indexPath.row]
        cell.configure(with: vitamin)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedVitamin = vitamins[indexPath.row]
        let addEditVitaminViewController = AddEditVitaminViewController()
        addEditVitaminViewController.vitamin = selectedVitamin
        addEditVitaminViewController.onSave = { [weak self] editedVitamin in
            self?.vitamins[indexPath.row] = editedVitamin
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(addEditVitaminViewController, animated: true)
    }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vitamins.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func addDisclaimer () {
        // Add a footer view with a disclaimer
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        let disclaimerLabel = UILabel()
        disclaimerLabel.text = """
            Information about each vitamin is not a medical advice. Please consult with a healthcare professional before starting any supplement regimen.
            Note: Dosage and timing may vary depending on individual needs and health conditions. Consult with a doctor or a nutritionist before taking any vitamin or mineral supplements.
        """

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
}
