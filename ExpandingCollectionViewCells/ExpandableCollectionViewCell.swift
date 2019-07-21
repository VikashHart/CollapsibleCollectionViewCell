import UIKit

class ExpandableCell: UICollectionViewCell, Expandable {

    private var initialFrame: CGRect?
    private var initialCornerRadius: CGFloat?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        configureAll()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Configuration

    private func configureAll() {
        configureCell()
        setupConstraints()
    }

    private func configureCell() {
        self.contentView.backgroundColor = .white

        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.green.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = self.layer.cornerRadius
    }

    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: topAnchor),
            self.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    // MARK: - Showing/Hiding Logic

    func hide(in collectionView: UICollectionView, frameOfSelectedCell: CGRect) {
        initialFrame = self.frame

        let currentY = self.frame.origin.y
        let newY: CGFloat

        if currentY < frameOfSelectedCell.origin.y {
            let offset = frameOfSelectedCell.origin.y - currentY
            newY = collectionView.contentOffset.y - offset
        } else {
            let offset = currentY - frameOfSelectedCell.maxY
            newY = collectionView.contentOffset.y + collectionView.frame.height + offset
        }

        self.frame.origin.y = newY

        layoutIfNeeded()
    }

    func show() {
        self.frame = initialFrame ?? self.frame

        initialFrame = nil

        layoutIfNeeded()
    }

    // MARK: - Expanding/Collapsing Logic

    func expand(in collectionView: UICollectionView) {
        initialFrame = self.frame
        initialCornerRadius = self.layer.cornerRadius

        self.layer.cornerRadius = 0
        self.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)

        layoutIfNeeded()
    }

    func collapse() {
        self.layer.cornerRadius = initialCornerRadius ?? self.layer.cornerRadius
        self.frame = initialFrame ?? self.frame

        initialFrame = nil
        initialCornerRadius = nil

        layoutIfNeeded()
    }
}
