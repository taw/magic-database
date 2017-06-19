describe GathererAdvancedSearchPage do
  let(:page) { described_class.new }
  it "returns lists of all sets" do
    expect(page.set_names).to include("Magic 2015 Core Set")
  end
end
