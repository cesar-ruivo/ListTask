protocol CodeView {
    func setupConstraints()
    func setupAddView()
    func setupView()
}

extension CodeView {
    func setupView() {
        setupAddView()
        setupConstraints()
    }
}
