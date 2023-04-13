import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let vitamins: [Vitamin] = [
        Vitamin(name: "Vitamin A", description: "Vitamin A is important for normal vision, the immune system, and reproduction.", optimalTime: "Morning", dosage: "900 mcg for men, 700 mcg for women"),
        Vitamin(name: "Vitamin C", description: "Vitamin C is important for the growth and repair of body tissues.", optimalTime: "Morning", dosage: "90 mg for men, 75 mg for women"),
        Vitamin(name: "Vitamin D", description: "Vitamin D helps your body absorb calcium, which is needed for strong bones.", optimalTime: "Morning", dosage: "20 mcg (800 IU)"),
        Vitamin(name: "Vitamin E", description: "Vitamin E acts as an antioxidant, helping to protect cells from damage caused by free radicals.", optimalTime: "Evening", dosage: "15 mg")
    ]

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vitamins"
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        setupTableViewConstraints()
    }

    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vitamins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = vitamins[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedVitamin = vitamins[indexPath.row]
        let detailViewController = VitaminDetailViewController(vitamin: selectedVitamin)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
