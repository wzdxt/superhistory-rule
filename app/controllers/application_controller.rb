class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_object
  before_action :authenticate_admin!

  def set_object
    @content = Content.find(params[:content_id]) if params[:content_id]
  end

  def nokogiri_parse string, url = nil, encoding = nil, options = nil
    doc = Nokogiri.parse string, url, encoding, options
    doc.css('script, style, head link').remove
    doc
  end
end
