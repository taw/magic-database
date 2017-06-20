describe GathererPrintedDetailsPage do
  let(:page) { described_class.new(id) }
  let(:card) { page.primary_card_details_box }

  describe "Ankh of Mishra from Alpha" do
    let(:id) { 1 }

    it do
      expect(card.id).to eq(1)
      expect(card.typeline).to eq("Continuous Artifact")
      expect(card.text).to eq("Ankh does 2 damage to anyone who puts a new land into play.")
    end
  end
end
