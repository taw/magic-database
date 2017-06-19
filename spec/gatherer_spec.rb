describe Gatherer do
  it ".set_names" do
    expect(Gatherer.set_names).to include("Magic 2015 Core Set")
  end

  it ".checklist_for_set" do
    expect(Gatherer.checklist_for_set("New Phyrexia")).to include(
      ["Act of Aggression", 230076, 1],
      ["Swamp", 227519, 2],
    )
  end
end
