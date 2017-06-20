describe GathererLanguagesPage do
  describe "Giant Spider from Eighth Edition" do
    let(:page) { described_class.new(45408) }

    it do
      expect(page.languages).to eq([
        [165148, "Ragno Gigante", "Italian", "Italiano"],
        [165862, "Aranha Gigante", "Portuguese (Brazil)", "Português"],
        [163225, "Araignée géante", "French", "Français"],
        [162868, "Riesenspinne", "German", "Deutsch"],
        [165505, "Araña gigante", "Spanish", "Español"]
      ])
    end
  end
end
