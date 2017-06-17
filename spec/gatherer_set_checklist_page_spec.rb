describe GathererSetChecklistPage do
  describe "From the Vault: Exiled" do
    let(:page) { described_class.new("From the Vault: Exiled", 0) }

    it do
      expect(page.cards).to eq([
        [194966, "1", "Balance", "Randy Gallegos", "White", "M", "From the Vault: Exiled"],
        [194969, "2", "Berserk", "Steve Prescott", "Green", "M", "From the Vault: Exiled"],
        [194967, "3", "Channel", "Rebecca Guay", "Green", "M", "From the Vault: Exiled"],
        [194971, "4", "Gifts Ungiven", "D. Alexander Gregory", "Blue", "M", "From the Vault: Exiled"],
        [194973, "5", "Goblin Lackey", "Christopher Moeller", "Red", "M", "From the Vault: Exiled"],
        [194974, "6", "Kird Ape", "Terese Nielsen", "Red", "M", "From the Vault: Exiled"],
        [194975, "7", "Lotus Petal", "April Lee", "", "M", "From the Vault: Exiled"],
        [194976, "8", "Mystical Tutor", "David O'Connor", "Blue", "M", "From the Vault: Exiled"],
        [194977, "9", "Necropotence", "Dave Kendall", "Black", "M", "From the Vault: Exiled"],
        [194972, "10", "Sensei's Divining Top", "Michael Sutfin", "", "M", "From the Vault: Exiled"],
        [194970, "11", "Serendib Efreet", "Matt Stewart", "Blue", "M", "From the Vault: Exiled"],
        [194978, "12", "Skullclamp", "Luca Zontini", "", "M", "From the Vault: Exiled"],
        [194968, "13", "Strip Mine", "John Avon", "", "M", "From the Vault: Exiled"],
        [194980, "14", "Tinker", "Chris Rahn", "Blue", "M", "From the Vault: Exiled"],
        [194979, "15", "Trinisphere", "Tim Hildebrandt", "", "M", "From the Vault: Exiled"],
      ])
      expect(page.last_page).to eq(0)
    end
  end

  describe "Limited Edition Alpha" do
    let(:set_name) { "Limited Edition Alpha" }

    it do
      # Crazy pagination, but should add to 295
      expect(described_class.new(set_name, 0).cards.size).to eq(101)
      expect(described_class.new(set_name, 1).cards.size).to eq(103)
      expect(described_class.new(set_name, 2).cards.size).to eq(91)
      expect(described_class.new(set_name, 0).last_page).to eq(2)
      expect(described_class.new(set_name, 1).last_page).to eq(2)
      expect(described_class.new(set_name, 2).last_page).to eq(2)
    end
  end
end
