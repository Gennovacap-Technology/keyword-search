class AccountsController < ApplicationController

  def index
    @selected_account = selected_account
    @accounts = {"Test Account" => '352-051-7337'}
  end

  def select
    if params[:account][:id].present?
      self.selected_account = params[:account][:id]
      flash[:notice] = "Selected account: %s" % selected_account
      redirect_to keywords_path
    else
      flash[:error] = "Please select a valid account before proceeding"
      redirect_to accounts_path
    end
  end
end
