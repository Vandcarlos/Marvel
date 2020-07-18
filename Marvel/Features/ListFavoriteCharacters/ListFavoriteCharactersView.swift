//

import MarvelUIKit

class ListFavoriteCharactersView: UIView {

    convenience init() {
        self.init(frame: .zero)
        configUI()
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            MUICharacterTableCell.self,
            forCellReuseIdentifier: MUICharacterTableCell.reuseIdentifier
        )

        tableView.rowHeight = 130
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.font = MUIFontManager.title.load(withSize: .lg)
        label.textColor = MUIColorManager.neutral.color
        label.text = LocalizableString.notHasCharactersToShow.message
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    func configUI() {
        backgroundColor = MUIColorManager.background.color
        addSubview(tableView)
        addSubview(emptyStateLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emptyStateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

}
