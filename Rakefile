SETS_TO_TEST = [
  ["LEA", "Limited Edition Alpha"],
  ["NPH", "New Phyrexia"],
  ["OGW", "Oath of the Gatewatch"],
  ["ROE", "Rise of the Eldrazi"],
  ["ISD", "Innistrad"],
]

desc "Get sample of mtgjson data"
task "mtgjson" do
  Pathname("output").mkpath
  SETS_TO_TEST.each do |set_code, set_name|
    sh "./bin/normalize_mtgjson  <~/d/mtgjson.com/json/#{set_code}-x.json >output/#{set_code}-mtgjson.json"
  end
end

desc "Run export script"
task "export:all" do
  Pathname("output").mkpath
  SETS_TO_TEST.each do |set_code, set_name|
    sh %Q[./bin/export_set_like_mtgjson "#{set_name}" output/#{set_code}-out.json]
  end
end

desc "Run export script for one set"
task "export", :set_code do |t, args|
  set_code = args.set_code
  raise unless set_code
  set_name = SETS_TO_TEST.to_h[set_code]
  Pathname("output").mkpath
  sh %Q[./bin/export_set_like_mtgjson "#{set_name}" output/#{set_code}-out.json]
end

desc "Statistics on how close we arediffstat"
task "diffstat" do
  SETS_TO_TEST.each do |set_code, set_name|
    system "diff -u output/#{set_code}-out.json output/#{set_code}-mtgjson.json | diffstat"
  end
end

desc "Display differences for specific set"
task "diff", :set_code do |t, args|
  set_code = args.set_code
  raise unless set_code
  system "diff -u output/#{set_code}-out.json output/#{set_code}-mtgjson.json"
end

desc "Display differences for specific set"
task "diff:all" do
  SETS_TO_TEST.each do |set_code, set_name|
    system "diff -u output/#{set_code}-out.json output/#{set_code}-mtgjson.json"
  end
end

desc "Fetch set metadata from mtgjson"
task "metadata:fetch" do
  sh "./bin/generate_set_metadata http://mtgjson.com/json/AllSets.json"
end
