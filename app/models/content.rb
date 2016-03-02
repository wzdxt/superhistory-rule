class Content < ActiveRecord::Base
  establish_connection :content
  content = Content.arel_table
  scope :id_order, -> { order(:id) }

  def get_content_rule
    host, port, path = fetch_url_info
    get_rule_by_host_port_path(host, port, path)
  end

  def self.first_no_rule
    self.id_order.select(:id, :url).each do |content|
      next if SkipContentRule.exists? content.id
      return content unless content.get_content_rule
    end
    nil
  end

  private

  def get_rule_by_host_port_path(host, port, path)
    parent_host = get_parent_host host
    (HostRule.host(host).port(port).ord_order + HostRule.host(host).no_port.ord_order +
        (parent_host ? HostRule.host(parent_host).no_port.include_sub.ord_order : [])).each do |host_rule|
      return [host_rule, false] if host_rule.excluded?
      if ret = host_rule.get_content_rule_by_path(path)
        return ret
      end
    end
    nil
  end

  def fetch_url_info
    uri = URI.parse self.url
    [uri.host, uri.port, uri.path]
  end

  def get_parent_host(host)
    s = host.split('.')
    s.size < 3 ? nil : s[1..-1].join('.')
  end
end
