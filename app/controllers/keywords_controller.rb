class KeywordsController < ApplicationController
  before_action :set_result, only: [ :index, :search ]

  def index
  end

  def search
    api = get_adwords_api
    targeting_idea_service = TargetingIdeaService.new(
      api,
      keywords:  search_params[:search],
      locations: search_params[:locations]
    )

    if targeting_idea_service.valid?
      @result = TargetingIdeas.new(targeting_idea_service.fetch).all
      flash.now[:success] = "Search completed successfully"
    else
      flash.now[:error] = targeting_idea_service.errors.full_messages.join("<br/>").html_safe
    end

    render :index
  end

private

  def search_params
    params.require(:keywords).permit(:search, :locations).tap do |object|
      object[:locations] = [ Country.find_by_code(object[:locations]).try(:id) ]
      object[:search] = [ object[:search] ]
    end
  end

  def set_result
    @result = []
  end
end
