describe GathererSetChecklistPage do
  describe "From the Vault: Exiled" do
    let(:page) { described_class.new("From the Vault: Exiled") }

    it do
      expect(page.cards).to eq([
        ["Balance", 194966, 1],
        ["Berserk", 194969, 1],
        ["Channel", 194967, 1],
        ["Gifts Ungiven", 194971, 1],
        ["Goblin Lackey", 194973, 1],
        ["Kird Ape", 194974, 1],
        ["Lotus Petal", 194975, 1],
        ["Mystical Tutor", 194976, 1],
        ["Necropotence", 194977, 1],
        ["Sensei's Divining Top", 194972, 1],
        ["Serendib Efreet", 194970, 1],
        ["Skullclamp", 194978, 1],
        ["Strip Mine", 194968, 1],
        ["Tinker", 194980, 1],
        ["Trinisphere", 194979, 1],
      ])
      expect(page.last_page).to eq(0)
      expect(page.last_page?).to eq(true)
      expect(page.next_page).to eq(nil)
    end
  end

  describe "Limited Edition Alpha" do
    let(:set_name) { "Limited Edition Alpha" }
    let(:page0) { described_class.new(set_name, 0) }
    let(:page1) { described_class.new(set_name, 1) }
    let(:page2) { described_class.new(set_name, 2) }

    it do
      # Pagination is up to 100 unique cards
      # So multiple versions of same card (mostly basic lands)
      # will get included on same page
      expect(page0.cards.size).to eq(100)
      expect(page0.cards.map(&:last).inject(&:+)).to eq(101)
      expect(page1.cards.size).to eq(100)
      expect(page1.cards.map(&:last).inject(&:+)).to eq(103)
      expect(page2.cards.size).to eq(90)
      expect(page2.cards.map(&:last).inject(&:+)).to eq(91)
      expect(page0.last_page).to eq(2)
      expect(page1.last_page).to eq(2)
      expect(page2.last_page).to eq(2)
      expect(page0.last_page?).to eq(false)
      expect(page1.last_page?).to eq(false)
      expect(page2.last_page?).to eq(true)
      expect(page0.next_page).to eq(page1)
      expect(page1.next_page).to eq(page2)
      expect(page2.next_page).to eq(nil)
    end
  end
end
