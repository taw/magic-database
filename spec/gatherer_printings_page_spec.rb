describe GathererPrintingsPage do
  describe "Dig Through Time" do
    let(:page) { described_class.new(386518) }
    it do
      expect(page.legalities).to eq([
        ["Modern", "Banned"],
        ["Khans of Tarkir Block", "Legal"],
        ["Legacy", "Banned"],
        ["Vintage", "Restricted"],
        ["Commander", "Legal"],
      ])
    end
  end
end
