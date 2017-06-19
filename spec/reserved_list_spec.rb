describe ReservedList do
  it do
    expect(ReservedList).to include("Black Lotus")
    expect(ReservedList).to_not include("Birthing Pod")
  end
end
