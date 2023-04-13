import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var vitamins: [Vitamin] = [
        Vitamin(name: "Vitamin A", description: "Vitamin A is important for normal vision, the immune system, and reproduction.", optimalTime: "Morning", dosage: "900 mcg for men, 700 mcg for women"),
        Vitamin(name: "Vitamin C", description: "Vitamin C is important for the growth and repair of body tissues.", optimalTime: "Morning", dosage: "90 mg for men, 75 mg for women"),
        Vitamin(name: "Vitamin D", description: "Vitamin D helps your body absorb calcium, which is needed for strong bones.", optimalTime: "Morning", dosage: "20 mcg (800 IU)")
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        setupTableViewConstraints()
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
        let addEditVitaminViewController = AddEditVitaminViewController()
        addEditVitaminViewController.vitamin = selectedVitamin
        addEditVitaminViewController.onSave = { [weak self] editedVitamin in
            self?.vitamins[indexPath.row] = editedVitamin
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(addEditVitaminViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vitamins.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
