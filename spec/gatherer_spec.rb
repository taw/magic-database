describe Gatherer do
  it ".set_names" do
    expect(Gatherer.set_names).to include("Magic 2015 Core Set")
  end

  it ".checklist_for_set" do
    expect(Gatherer.instance_eval{ checklist_for_set("New Phyrexia") }).to include(
      ["Act of Aggression", 230076, 1],
      ["Swamp", 227519, 2],
    )
  end

  it ".card_ids_for_set" do
    expect(Gatherer.card_ids_for_set("New Phyrexia")).to include(
      ["Act of Aggression", 230076],
      ["Swamp", 227519],
      ["Swamp", 227521],
    )
  end
end
