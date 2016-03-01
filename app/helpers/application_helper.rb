module ApplicationHelper
  def nokogiri_parse string, url = nil, encoding = nil, options = nil
    doc = Nokogiri.parse string, url, encoding, options
    doc.css('script, style, head link').remove
    doc
  end
end
