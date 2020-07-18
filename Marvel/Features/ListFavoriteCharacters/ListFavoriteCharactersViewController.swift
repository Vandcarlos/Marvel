//

import MarvelUIKit

class ListFavoriteCharactersViewController: MUISearchViewController, ListFavoriteCharactersViewToPresenter {

    weak var presenter: ListFavoriteCharactersPresenterToView?

    convenience init() {
        self.init(nibName: nil, bundle: nil)
        title = LocalizableString.favorites.message
        tabBarItem.image = MUIImageManager.heartTwo.icon
    }

    // MARK: - View

    lazy var currentView: ListFavoriteCharactersView = {
        let view = ListFavoriteCharactersView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = currentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    // MARK: MUISearchViewController methods

    override func didCurrentQueryChanged() {
        presenter?.searchTapped()
    }

    // MARK: View to presenter stubs

    var query: String {
        currentQuery
    }

    func reloadCharcters() {
        DispatchQueue.main.async { [weak self] in
            self?.currentView.tableView.reloadData()
        }
    }

    func showEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.currentView.tableView.isHidden = true
            self?.currentView.emptyStateLabel.isHidden = false
        }
    }

    func hideEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.currentView.tableView.isHidden = false
            self?.currentView.emptyStateLabel.isHidden = true
        }
    }

}

extension ListFavoriteCharactersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.currentCharacters.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MUICharacterTableCell.reuseIdentifier,
            for: indexPath
        )

        guard let characterTableCell = cell as? MUICharacterTableCell else { return cell }
        guard let presenter = self.presenter else { return cell }

        if indexPath.row < presenter.currentCharacters.count {
            let character = presenter.currentCharacters[indexPath.row]

            characterTableCell.hideSkeleton()
            characterTableCell.nameLabel.text = character.name
            characterTableCell.thumbnailImageView.image = character.thumbnail
        } else {
            characterTableCell.showAnimatedGradientSkeleton()
        }

        presenter.configuredCell(withRow: indexPath.row)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        presenter?.deleteFavoriteButtonTapped(inRow: indexPath.row)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.itemTapped(withIndex: indexPath.row)
    }

}
