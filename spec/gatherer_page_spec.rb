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
      expect(page.power).to eq(nil)
      expect(page.toughness).to eq(nil)
      expect(page.card_number).to eq(nil)
      expect(page.flavor_text).to eq(nil)
    end
  end

  describe "Giant Spider from Eighth Edition" do
    let(:page) { GathererPage.new(45408) }

    it do
      expect(page.card_name).to eq("Giant Spider")
      expect(page.mana_cost).to eq("3G")
      expect(page.converted_mana_cost).to eq(4)
      expect(page.types).to eq("Creature — Spider")
      expect(page.card_text).to eq("Reach (This creature can block creatures with flying.)")
      expect(page.flavor_text).to eq(%Q[Watching the spider's web\n—Llanowar expression meaning\n"focusing on the wrong thing"])
      expect(page.rarity).to eq("Common")
      expect(page.power).to eq("2")
      expect(page.toughness).to eq("4")
      expect(page.artist).to eq("Randy Gallegos")
      expect(page.card_number).to eq("255")
      expect(page.rulings).to eq([
        ["4/1/2008", "This card now uses the Reach keyword ability to enable the blocking of flying creatures. This works because a creature with flying can only be blocked by creatures with flying or reach."]
      ])
      expect(page.expansion).to eq("Eighth Edition (Common)")
      expect(page.all_sets).to eq([
        [154, "Limited Edition Alpha (Common)"],
        [449, "Limited Edition Beta (Common)"],
        [751, "Unlimited Edition (Common)"],
        [1249, "Revised Edition (Common)"],
        [2216, "Fourth Edition (Common)"],
        [3983, "Fifth Edition (Common)"],
        [14676, "Classic Sixth Edition (Common)"],
        [11302, "Seventh Edition (Common)"],
        [45408, "Eighth Edition (Common)"],
        [83105, "Ninth Edition (Common)"],
        [129570, "Tenth Edition (Common)"],
        [4298, "Portal (Common)"],
        [189895, "Magic 2010 (Common)"],
        [205225, "Magic 2011 (Common)"],
        [233232, "Magic 2012 (Common)"],
        [370781, "Magic 2014 Core Set (Common)"],
        [426868, "Amonkhet (Common)"],
      ])
    end
  end
end

__END__

TODO: card vs reminder text
