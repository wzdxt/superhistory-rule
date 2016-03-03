module ApplicationHelper
  def nokogiri_parse string, url = nil, encoding = nil, options = nil
    doc = Nokogiri.parse string, url, encoding, options
    doc.css('script, iframe, frameset').remove   # must same with ApplicationController
    doc
  end
end
