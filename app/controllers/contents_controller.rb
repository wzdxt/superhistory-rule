class ContentsController < ApplicationController
  def source
    doc = Nokogiri.parse @content.source
    doc.css('script').remove
    render :html => doc.to_s.html_safe
  end
end
