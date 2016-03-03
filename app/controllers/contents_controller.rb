class ContentsController < ApplicationController
  def source
    doc = nokogiri_parse @content.source
    render :html => doc.to_s.html_safe
  end

  def index
    @contents = Content.select(:id, :url).page(params[:page]).per(30)
  end
end
