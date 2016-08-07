class TargetingIdeas
  attr_reader :total_num_entries, :entries

  def initialize data
    data = data.with_indifferent_access
    @total_num_entries = data['total_num_entries']
    @entries           = data['entries']
  end

  def all
    entries.collect do |entry|
      OpenStruct.new(
        keyword: keyword(entry),
        search_volume: search_volume(entry)
      )
    end
  end

private

  def keyword entry
    entry['data']['KEYWORD_TEXT']['value']
  end

  def search_volume entry
    entry['data']['SEARCH_VOLUME']['value']
  end
end
