class Page < ActiveRecord::Base
  establish_connection :page

  def get_rule
    host, port, path = fetch_url_info
    HostRule.get_rule_by_host_port_path(host, port, path)
  end

  private

  def fetch_url_info
    uri = URI.parse self.url
    [uri.host, uri.port, uri.path]
  end
end
