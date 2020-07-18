//

import MarvelUIKit

class ListCharactersFromWebView: UIView {

    convenience init() {
        self.init(frame: .zero)
        configUI()
    }

    var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let cellWidth = (UIScreen.main.bounds.width / 5) * 2
        let cellHeight = UIScreen.main.bounds.height / 3

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(
            MUICharacterCollectionCell.self,
            forCellWithReuseIdentifier: MUICharacterCollectionCell.reuseIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
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

    lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizableString.tryAgain.message, for: .normal)
        button.setTitleColor(MUIColorManager.neutral.color, for: .normal)
        button.titleLabel?.font = MUIFontManager.body.load(withSize: .md)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = MUIColorManager.alert.color
        button.isHidden = true
        return button
    }()

    func configUI() {
        backgroundColor = MUIColorManager.background.color
        addSubview(collectionView)
        addSubview(tryAgainButton)
        addSubview(emptyStateLabel)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),

            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            tryAgainButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            tryAgainButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            tryAgainButton.bottomAnchor.constraint(equalTo: bottomAnchor),

            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emptyStateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

}
