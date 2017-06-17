describe GathererLanguagesPage do
  describe "Giant Spider from Eighth Edition" do
    let(:page) { described_class.new(45408) }

    it do
      expect(page.languages).to eq([
        ["Ragno Gigante", "Italian", "Italiano"],
        ["Aranha Gigante", "Portuguese (Brazil)", "Português"],
        ["Araignée géante", "French", "Français"],
        ["Riesenspinne", "German", "Deutsch"],
        ["Araña gigante", "Spanish", "Español"]
      ])
    end
  end
end
