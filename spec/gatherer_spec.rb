describe Gatherer do
  it ".set_names" do
    expect(Gatherer.set_names).to include("Magic 2015 Core Set")
  end

  it ".checklist_for_set" do
    expect(Gatherer.checklist_for_set("New Phyrexia")).to include(
      [230076, "78", "Act of Aggression", "Whit Brachna", "Red", "U", "New Phyrexia"]
    )
  end
end
