class ContentsController < ApplicationController
  def source
    doc = Nokogiri.parse @content.source
    doc.css('script iframe frameset').remove    # must same with rules/new
    render :html => doc.to_s.html_safe
  end

  def index
    @contents = Content.select(:id, :url).page(params[:page]).per(30)
  end
end
