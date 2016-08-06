module KeywordsHelper
  def country_codes
    Country.list_with_names_and_codes
  end
end
