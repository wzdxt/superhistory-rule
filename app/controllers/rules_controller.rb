class RulesController < ApplicationController
  def new
    if @content
      rule, included = @content.get_content_rule
      if rule and rule.is_a? PathRule
        @host_rule = rule.host_rule
        @path_rule = rule
      elsif rule and rule.is_a? HostRule
        @host_rule = rule
      end
    else
      @content = Content.first_no_rule
      if @content.nil?
        return redirect_to contents_path
      end
      @content.reload
    end
    @uri = URI.parse @content.url
    @path, @ext = path_ext @uri.path
    @host_rule ||= HostRule.new :host => @uri.host, :port => nil, :include_sub => false, :excluded => false
    @path_rule ||= PathRule.new :path_pattern => @uri.path, :excluded => false,
                                :title_css_path => 'head title', :content_css_paths => '[]'
    @existed_host_rules = HostRule.matched_rules @uri.host, @uri.port
  end

  def create
    HostRule.transaction do
      if host_rule_params[:id].present?
        host_rule = HostRule.find(host_rule_params[:id])
      else
        host_rule = HostRule.new host_rule_params.except(:id)
        host_rule = HostRule.find_or_create_by! host_rule.attributes.except('id', 'ord', 'created_at', 'updated_at')
      end
      unless host_rule.excluded?
        path_rule = PathRule.new path_rule_params
        path_rule.update! :host_rule_id => host_rule.id
      end
    end
    redirect_to new_rule_path
  end

  private

  def host_rule_params
    params.require(:host_rule).permit(:id, :host, :port, :include_sub, :excluded, :ord)
  end

  def path_rule_params
    params[:path_rule][:path_pattern] = params[:path_rule][:path_pattern_items].join('\\/')
    params[:path_rule][:path_pattern] += '\\' + params[:path_rule][:path_pattern_ext] if params[:path_rule][:path_pattern_ext].present?
    params[:path_rule][:path_pattern] = '^\\/' + params[:path_rule][:path_pattern] + '$'
    params[:path_rule][:content_css_paths] = (params[:path_rule][:content_css_path_items] || []).to_json
    params.require(:path_rule).permit(:path_pattern, :excluded, :title_css_path, :content_css_paths, :ord)
  end

  def path_ext s
    ext = s.scan(/\.\w+$/)[-1]
    if ext.nil?
      [s, nil]
    else
      path = s[0..-(ext.length+1)]
      [path, ext]
    end
  end
end


