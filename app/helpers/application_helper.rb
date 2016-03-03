module ApplicationHelper
  def nokogiri_parse string, url = nil, encoding = nil, options = nil
    doc = Nokogiri.parse string, url, encoding, options
    doc.css('script, iframe, frameset').remove   # must same with ApplicationController
    doc.css('a').each{|a|a.remove_attribute 'href'}
    doc.css('a').each{|a|a.set_attribute 'onclick', 'return false;'}
    doc
  end
end
