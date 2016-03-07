class PagesController < ApplicationController
  def index
    @pages = Page.page(params[:page]).per(30)
  end
end
