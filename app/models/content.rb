class Content < ActiveRecord::Base
  establish_connection :content
  content = Content.arel_table
  scope :id_order, -> { order(:id) }

  def get_content_rule
    host, port, path = fetch_url_info
    HostRule.get_rule_by_host_port_path(host, port, path)
  end

  def self.first_no_rule
    self.id_order.select(:id, :url).each do |content|
      next if SkipContentRule.exists? content.id
      return content unless content.get_content_rule
    end
    nil
  end

  private

  def fetch_url_info
    uri = URI.parse self.url
    [uri.host, uri.port, uri.path]
  end
end
