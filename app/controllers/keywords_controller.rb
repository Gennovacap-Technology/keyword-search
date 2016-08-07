class KeywordsController < ApplicationController
  def index
    api = get_adwords_api
    data = TargetingIdeaService.new(api).fetch
    @result = TargetingIdeas.new(data).all
  end

  def search
  end
end
