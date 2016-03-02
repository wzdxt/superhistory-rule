class PathRule < ActiveRecord::Base
  belongs_to :host_rule
  scope :ord_order, -> { order(:ord) }

  def content_css_paths_data
    JSON.parse self.content_css_paths
  end

  def content_css_paths_data=(data)
    self.content_css_paths = data.to_json
  end
end
