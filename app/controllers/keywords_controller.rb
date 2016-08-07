class KeywordsController < ApplicationController
  def index
    api = get_adwords_api
    TargetingIdeaService.new(api).run!
  end

  def search
  end
end
