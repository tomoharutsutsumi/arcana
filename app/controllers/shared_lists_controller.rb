class SharedListsController < ApplicationController
  def show
    @list = ShareHash.find_by(hash_string: params[:hash_string]).list
  end

  private

  def authenticate?
    false
  end
end