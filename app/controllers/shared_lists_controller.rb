class SharedListsController < ApplicationController
  def show
    @list = List.find_by(share_hash: params[:share_hash])
  end

  private

  def authenticate?
    false
  end
end