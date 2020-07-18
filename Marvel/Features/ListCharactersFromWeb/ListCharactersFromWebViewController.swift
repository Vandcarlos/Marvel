//

import MarvelUIKit

class ListCharactersFromWebViewController: MUISearchViewController, ListCharactersFromWebViewToPresenter {

    convenience init() {
        self.init(nibName: nil, bundle: nil)
        title = LocalizableString.list.message
        tabBarItem.image = MUIImageManager.menu.icon
    }

    // MARK: View to presenter stubs

    var presenter: ListCharactersFromWebPresenterToView!

    var query: String {
        currentQuery
    }

    func reloadCharcters() {
        DispatchQueue.main.async { [weak self] in
            self?.currentView.collectionView.reloadData()
        }
    }

    func showErrorAboutFechCharacters(withMessage message: String) {
        let title = LocalizableString.errorOnFetchCharacters.message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let tryAgainActionTitle = LocalizableString.tryAgain.message
        let tryAgatinAction = UIAlertAction(title: tryAgainActionTitle, style: .default) { [weak self] _ in
            self?.presenter.retryLoad()
        }
        alert.addAction(tryAgatinAction)

        let cancelActionTitle = LocalizableString.cancel.message

        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel) { [weak self] _ in
            self?.presenter.cancelWhenErrorTapped()
        }

        alert.addAction(cancelAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }

    func showEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.currentView.collectionView.isHidden = true
            self?.currentView.emptyStateLabel.isHidden = false
        }
    }

    func hideEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.currentView.collectionView.isHidden = false
            self?.currentView.emptyStateLabel.isHidden = true
        }
    }

    func showRetryButton() {
        DispatchQueue.main.async { [weak self] in
            self?.currentView.tryAgainButton.isHidden = false
        }
    }

    // MARK: - View

    lazy var currentView: ListCharactersFromWebView = {
        let view = ListCharactersFromWebView()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        return view
    }()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = currentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        currentView.tryAgainButton.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
    }

    // MARK: MUISearchViewController methods

    override func didCurrentQueryChanged() {
        presenter.searchTapped()
    }

    // MARK: View Actions

    @objc private func tryAgainTapped() {
        currentView.tryAgainButton.isHidden = true
        presenter.retryLoad()
    }

}

extension ListCharactersFromWebViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfRows
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MUICharacterCollectionCell.reuseIdentifier,
            for: indexPath
        )

        guard let characterCollectionCell = cell as? MUICharacterCollectionCell else { return cell }

        if indexPath.row < presenter.currentCharacters.count {
            let character = presenter.currentCharacters[indexPath.row]

            characterCollectionCell.hideSkeleton()
            characterCollectionCell.nameLabel.text = character.name
            characterCollectionCell.favoriteButton.isFavorite = character.favorited
            characterCollectionCell.tag = indexPath.row
            characterCollectionCell.thumbnailImageView.image = character.thumbnail
            characterCollectionCell.delegate = self
        } else {
            characterCollectionCell.showAnimatedGradientSkeleton()
        }

        presenter.configuredCell(withRow: indexPath.row)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.itemTapped(withIndex: indexPath.row)
    }

}

extension ListCharactersFromWebViewController: MUICharacterCollectionCellDelegate {

    func didToggleFavorite(tag: Int) {
        presenter.favoriteButtonTapped(withIndex: tag)
    }

}
