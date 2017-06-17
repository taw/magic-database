describe GathererPage do

  describe "Ankh of Mishra from Alpha" do
    let(:page) { GathererPage.new(1) }
    it "fetches" do
      expect(page.doc).to be_instance_of(Nokogiri::HTML::Document)
    end

    it do
      expect(page.card_name).to eq("Ankh of Mishra")
      expect(page.mana_cost).to eq("2")
      expect(page.converted_mana_cost).to eq(2)
      expect(page.types).to eq("Artifact")
      expect(page.card_text).to eq("Whenever a land enters the battlefield, Ankh of Mishra deals 2 damage to that land's controller.")
      expect(page.rarity).to eq("Rare")
      expect(page.artist).to eq("Amy Weber")
      expect(page.rulings).to eq([
        ["10/4/2004",	"This triggers on any land entering the battlefield. This includes playing a land or putting a land onto the battlefield using a spell or ability."],
        ["10/4/2004",	"It determines the land’s controller at the time the ability resolves. If the land leaves the battlefield before the ability resolves, the land’s last controller before it left is used."]
      ])
      expect(page.expansion).to eq("Limited Edition Alpha (Rare)")
      expect(page.all_sets).to eq([
        [1, "Limited Edition Alpha (Rare)"],
        [296, "Limited Edition Beta (Rare)"],
        [598, "Unlimited Edition (Rare)"],
        [1094, "Revised Edition (Rare)"],
        [2017, "Fourth Edition (Rare)"],
        [3760, "Fifth Edition (Rare)"],
        [14771, "Classic Sixth Edition (Rare)"],
        [159251, "Masters Edition (Rare)"],
        [382844, "Vintage Masters (Rare)"],
      ])
    end
  end
end
