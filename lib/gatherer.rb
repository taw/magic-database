class Gatherer
  def self.set_names
    GathererAdvancedSearchPage.new.set_names
  end

  def self.checklist_for_set(set_name)
    result = []
    checklist_page = GathererSetChecklistPage.new(set_name, 0)
    while checklist_page
      checklist_page.cards.each do |card_row|
        result << card_row
      end
      checklist_page = checklist_page.next_page
    end
    result.uniq
  end
end
