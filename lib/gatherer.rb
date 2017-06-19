class Gatherer
  class << self
    def set_names
      GathererAdvancedSearchPage.new.set_names
    end

    def card_ids_for_set(set_name)
      result = []
      checklist_for_set(set_name).each do |card_name, first_id, count|
        if count == 1
          result << [card_name, first_id]
        else
          variation_ids = GathererDetailsPage.new(first_id).variations
          unless variation_ids
            warn "#{card_name} supposed to have variations, but not seeing any. Split card???"
            result << [card_name, first_id]
            next
          end
          raise "Not as many variations as checklist said they'd be" unless count == variation_ids.size
          variation_ids.each do |variation_id|
            result << [card_name, variation_id]
          end
        end
      end
      result
    end

    private def checklist_for_set(set_name)
      result = []
      checklist_page = GathererSetChecklistPage.new(set_name, 0)
      while checklist_page
        checklist_page.cards.each do |card_row|
          result << card_row
        end
        checklist_page = checklist_page.next_page
      end
      result
    end
  end
end
