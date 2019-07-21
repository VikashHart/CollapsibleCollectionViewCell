import UIKit

class MainCollectionViewCell: ExpandableCell {

    var scrollViewBottomConstraintToBottom: NSLayoutConstraint?
    var scrollViewBottomConstraintToTop: NSLayoutConstraint?

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "trees")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.delaysContentTouches = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    lazy var scrollViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

   lazy var label: UILabel = {
        let label = UILabel()
    label.text = "NewLabellhbalbgbkbjbg;qbergbebwhberbkbrkerie rekberkgberkgbqerg er gergjbergkjbergkberkgbwerge gewrgjerberk geqkrgqjekrg eqgqe rgerjkg eqrg qergqerjgqergjqehr gqebrgibqergeqrgk eqrg er gqergjbeqreqrgneqrlgeqr eqrg qerg qerngqejrngjeqrnge NewLabellhbalbgbkbjbg;qbergbebwhberbkbrkerie rekberkgberkgbqerg er gergjbergkjbergkberkgbwerge gewrgjerberk geqkrgqjekrg eqgqe rgerjkg eqrg qergqerjgqergjqehr gqebrgibqergeqrgk eqrg er gqergjbeqreqrgneqrlgeqr eqrg qerg qerngqejrngjeqrnge NewLabellhbalbgbkbjbg;qbergbebwhberbkbrkerie rekberkgberkgbqerg er gergjbergkjbergkberkgbwerge gewrgjerberk geqkrgqjekrg eqgqe rgerjkg eqrg qergqerjgqergjqehr gqebrgibqergeqrgk eqrg er gqergjbeqreqrgneqrlgeqr eqrg qerg qerngqejrngjeqrnge NewLabellhbalbgbkbjbg;qbergbebwhberbkbrkerie rekberkgberkgbqerg er gergjbergkjbergkberkgbwerge gewrgjerberk geqkrgqjekrg eqgqe rgerjkg eqrg qergqerjgqergjqehr gqebrgibqergeqrgk eqrg er gqergjbeqreqrgneqrlgeqr eqrg qerg qerngqejrngjeqrnge NewLabellhbalbgbkbjbg;qbergbebwhberbkbrkerie rekberkgberkgbqerg er gergjbergkjbergkberkgbwerge gewrgjerberk geqkrgqjekrg eqgqe rgerjkg eqrg qergqerjgqergjqehr gqebrgibqergeqrgk eqrg er gqergjbeqreqrgneqrlgeqr eqrg qerg qerngqejrngjeqrnge "
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var noteTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Text"
        tf.contentMode = .center
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    // MARK: Lifecycle methods

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupViews()
    }

    // MARK: Override methods

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func expand(in collectionView: UICollectionView) {
        scrollViewBottomConstraintToTop?.isActive = false
        scrollViewBottomConstraintToBottom?.isActive = true

        super.expand(in: collectionView)
    }

    override func collapse() {
        scrollViewBottomConstraintToTop?.isActive = true
        scrollViewBottomConstraintToBottom?.isActive = false

        super.collapse()
    }

    // MARK: Private functions

    private func setupViews() {
        setupImageView()
        setupScrollView()
        setupContainerView()
        setupLabel()
        setupNoteTF()
    }

    // All Constraints Go Here.
    private func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1)
            ])
    }

    private func setupScrollView() {
        addSubview(scrollView)

        scrollViewBottomConstraintToBottom = scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        scrollViewBottomConstraintToTop = scrollView.bottomAnchor.constraint(equalTo: scrollView.topAnchor)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        scrollViewBottomConstraintToTop?.isActive = true
    }

    private func setupContainerView() {
        scrollView.addSubview(scrollViewContainer)
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor),
            scrollViewContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            ])
    }

    private func setupLabel() {
        scrollViewContainer.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -20),
//            label.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor, constant: -20)
            ])
    }

    private func setupNoteTF() {
        scrollViewContainer.addSubview(noteTextField)
        NSLayoutConstraint.activate([
            noteTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            noteTextField.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 20),
            noteTextField.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -20),
            noteTextField.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor, constant: -10),
            noteTextField.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
}
