class RulesController < ApplicationController
  def new
    unless @content
      @content = Content.first_no_rule
      if @content.nil?
        return redirect_to host_rules_path
      end
      @content.reload
    end
    @uri = URI.parse @content.url
    @host_rule = HostRule.new :host => @uri.host, :port => nil, :include_sub => false, :excluded => false
    @path_rule = PathRule.new :path_pattern => @uri.path, :excluded => false,
                              :title_css_path => 'head title', :content_css_paths => '[]'
    @existed_host_rules = HostRule.matched_rules @uri.host, @uri.port
  end

  def create
    if host_rule_params[:id]
      host_rule = HostRule.find(host_rule_params[:id])
    else
      host_rule = HostRule.create! host_rule_params
    end
    unless host_rule.excluded?
      path_rule = PathRule.new path_rule_params
      path_rule.update! :host_rule_id => host_rule.id
    end
    redirect_to new_rule_path
  end

  private

  def host_rule_params
    params[:host_rule][:id] = nil unless params[:host_rule][:id].present?
    params[:host_rule][:port] = nil unless params[:host_rule][:port].present?
    params[:host_rule][:ord] = nil unless params[:host_rule][:ord].present?
    params.require(:host_rule).permit(:id, :host, :port, :include_sub, :excluded, :ord)
  end

  def path_rule_params
    params[:path_rule][:path_pattern] = '/^/' + params[:path_rule][:path_pattern_items].join('/') + '$/'
    params[:path_rule][:content_css_paths] = params[:path_rule][:content_css_path_items].to_json
    params.require(:path_rule).permit(:path_pattern, :excluded, :title_css_path, :content_css_paths, :ord)
  end
end
