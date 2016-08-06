class TargetingIdeaService
  include ActiveModel::Model

  attr_reader :adwords, :locations, :keywords, :languages

  validates_presence_of :adwords, :locations, :keywords

  API_VERSION = :v201605
  PAGE_SIZE = 100

  def initialize adwords, keywords = [], locations = []
    @adwords = adwords
    @keywords = keywords
    @locations = locations
    @languages = [1000]
  end

  def run!
    if self.valid?
    else
      false
    end
  end

  def self.api_version
    API_VERSION
  end

private

  def selector
    {
      :idea_type => 'KEYWORD',
      :request_type => 'IDEAS',
      :requested_attribute_types =>
      ['KEYWORD_TEXT', 'SEARCH_VOLUME', 'CATEGORY_PRODUCTS_AND_SERVICES'],
      :search_parameters => [
        {
          # The 'xsi_type' field allows you to specify the xsi:type of the object
          # being created. It's only necessary when you must provide an explicit
          # type that the client library can't infer.
          :xsi_type => 'RelatedToQuerySearchParameter',
          :queries => keywords
        },
        {
          # Language setting (optional).
          # The ID can be found in the documentation:
          #  https://developers.google.com/adwords/api/docs/appendix/languagecodes
          # Only one LanguageSearchParameter is allowed per request.
          xsi_type: 'LanguageSearchParameter',
          languages: prepare_languages_params
        },
        {
          xsi_type: 'LocationSearchParameter',
          locations: prepare_locations_params
        }
        }
      ],
      paging: {
        start_index: 0,
        number_results: PAGE_SIZE
      }
    }
  end

  def service
    @service ||= adwords.service(:TargetingIdeaService, API_VERSION)
  end

  def prepare_locations_params
    locations.map { |value| { id: value } }
  end

  def prepare_languages_params
    languages.map { |value| { id: value } }
  end

end
