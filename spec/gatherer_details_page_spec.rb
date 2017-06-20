describe GathererDetailsPage do
  let(:page) { described_class.new(id) }
  let(:card) { page.primary_card_details_box }

  describe "Ankh of Mishra from Alpha" do
    let(:id) { 1 }
    it "fetches" do
      expect(page.doc).to be_instance_of(Nokogiri::HTML::Document)
    end

    it do
      expect(card.name).to eq("Ankh of Mishra")
      expect(card.mana_cost).to eq("{2}")
      expect(card.converted_mana_cost).to eq(2)
      expect(card.typeline).to eq("Artifact")
      expect(card.text).to eq("Whenever a land enters the battlefield, Ankh of Mishra deals 2 damage to that land's controller.")
      expect(card.rarity).to eq("Rare")
      expect(card.artist).to eq("Amy Weber")
      expect(card.rulings).to eq([
        ["2004-10-04", "This triggers on any land entering the battlefield. This includes playing a land or putting a land onto the battlefield using a spell or ability."],
        ["2004-10-04", "It determines the land’s controller at the time the ability resolves. If the land leaves the battlefield before the ability resolves, the land’s last controller before it left is used."]
      ])
      expect(card.expansion).to eq("Limited Edition Alpha (Rare)")
      expect(card.all_sets).to eq([
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
      expect(card.power).to eq(nil)
      expect(card.toughness).to eq(nil)
      expect(card.number).to eq(nil)
      expect(card.flavor_text).to eq(nil)
      expect(card.supertypes).to eq([])
      expect(card.types).to eq(["Artifact"])
      expect(card.subtypes).to eq([])
    end
  end

  describe "Giant Spider from Eighth Edition" do
    let(:id) { 45408 }

    it do
      expect(card.name).to eq("Giant Spider")
      expect(card.mana_cost).to eq("{3}{G}")
      expect(card.converted_mana_cost).to eq(4)
      expect(card.typeline).to eq("Creature — Spider")
      expect(card.text).to eq("Reach (This creature can block creatures with flying.)")
      expect(card.flavor_text).to eq(%Q[Watching the spider's web\n—Llanowar expression meaning\n"focusing on the wrong thing"])
      expect(card.rarity).to eq("Common")
      expect(card.power).to eq("2")
      expect(card.toughness).to eq("4")
      expect(card.artist).to eq("Randy Gallegos")
      expect(card.number).to eq("255")
      expect(card.rulings).to eq([
        ["2008-04-01", "This card now uses the Reach keyword ability to enable the blocking of flying creatures. This works because a creature with flying can only be blocked by creatures with flying or reach."]
      ])
      expect(card.expansion).to eq("Eighth Edition (Common)")
      expect(card.all_sets).to eq([
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
      expect(card.supertypes).to eq([])
      expect(card.types).to eq(["Creature"])
      expect(card.subtypes).to eq(["Spider"])
    end
  end

  describe "Unset - Little Girl" do
    let(:id) { 74257 }
    it do
      expect(card.mana_cost).to eq("{hw}")
      expect(card.converted_mana_cost).to eq(0.5)
      expect(card.power).to eq(".5")
      expect(card.toughness).to eq(".5")
    end
  end

  describe "Unset - Mons's Goblin Waiters" do
    let(:id) { 73957 }
    it do
      expect(card.text).to eq("Sacrifice a creature or land: Add {hr} to your mana pool.")
    end
  end

  describe "Unsets - Mox Lotus" do
    let(:id) { 74323 }
    it do
      expect(card.text).to eq(
        "{T}: Add {∞} to your mana pool.\n"+
        "{100}: Add one mana of any color to your mana pool.\n"+
        "You don't lose life due to mana burn."
      )
    end
  end

  describe "Birthing Pod" do
    let(:id) { 218006 }
    it do
      expect(card.mana_cost).to eq("{3}{G/P}")
      expect(card.text).to eq(
        "({G/P} can be paid with either {G} or 2 life.)\n"+
        "{1}{G/P}, {T}, Sacrifice a creature: Search your library for a creature card with converted mana cost equal to 1 plus the sacrificed creature's converted mana cost, put that card onto the battlefield, then shuffle your library. Activate this ability only any time you could cast a sorcery."
      )
    end
  end

  describe "Reaper King" do
    let(:id) { 159408 }
    it do
      expect(card.mana_cost).to eq("{2/W}{2/U}{2/B}{2/R}{2/G}")
      expect(card.text).to eq(
        "({2/W} can be paid with any two mana or with {W}. This card's converted mana cost is 10.)\n"+
        "Other Scarecrow creatures you control get +1/+1.\n"+
        "Whenever another Scarecrow enters the battlefield under your control, destroy target permanent.")
      expect(card.variations).to eq(nil)
      expect(card.current_variation).to eq(nil)
    end
  end

  describe "Wastes (variation 2 of 4)" do
    let(:id) { 407694 }
    it do
      expect(card.variations).to eq([
        407693,
        407694,
        407695,
        407696,
      ])
      expect(card.current_variation).to eq(2)
      expect(card.supertypes).to eq(["Basic"])
      expect(card.types).to eq(["Land"])
      expect(card.subtypes).to eq([])
    end
  end

  describe "Delver of Secrets" do
    let(:id) { 226749 }
    it do
      expect(card.name).to eq("Delver of Secrets")
    end
  end

  describe "Insectile Aberration" do
    let(:id) { 226755 }
    it do
      expect(card.name).to eq("Insectile Aberration")
    end
  end
end
