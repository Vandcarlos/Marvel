//

import MarvelUIKit

class DetailsCharacterView: UIView {

    convenience init() {
        self.init(frame: .zero)
        configUI()
    }

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    var thumbnail: MUIThumbnailImageView = {
        let thumbnail = MUIThumbnailImageView(size: .lgHeight)
        return thumbnail
    }()

    var favoriteButtonContainer: UIView = {
        let view = UIView()
        return view
    }()

    var favoriteButton: MUIFavoriteButton = {
        let favoriteButton = MUIFavoriteButton()
        return favoriteButton
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = MUIFontManager.title.load(withSize: .sm)
        label.textColor = MUIColorManager.neutral.color
        return label
    }()

    var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = MUIFontManager.body.load(withSize: .md)
        label.textColor = MUIColorManager.neutral.color
        return label
    }()

    var fillView: UIView = {
        let view = UIView()
        return view
    }()

    func configUI() {
        backgroundColor = MUIColorManager.background.color
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addArrangedSubview(thumbnail)
        contentView.addArrangedSubview(favoriteButtonContainer)

        favoriteButtonContainer.addSubview(favoriteButton)

        contentView.addArrangedSubview(nameLabel)
        contentView.addArrangedSubview(descLabel)
        contentView.addArrangedSubview(fillView)

        contentView.heightAnchor.constraint(equalTo: heightAnchor).priority = .defaultLow

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            favoriteButton.trailingAnchor.constraint(equalTo: favoriteButtonContainer.trailingAnchor),
            favoriteButton.topAnchor.constraint(equalTo: favoriteButtonContainer.topAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: favoriteButtonContainer.bottomAnchor)

        ])
    }
}
