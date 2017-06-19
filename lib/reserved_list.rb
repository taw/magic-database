module ReservedList
  LIST = (Pathname(__dir__) + "../data/reserved_list.txt").readlines.map(&:chomp).to_set

  def self.include?(card_name)
    LIST.include?(card_name)
  end
end
