class ContentsController < ApplicationController
  def source
    render :html => @content.source.html_safe
  end
end
