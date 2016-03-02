class PathRulesController < ApplicationController
  before_action :set_path_rule, only: [:show, :edit, :update, :destroy]

  # GET /path_rules
  def index
    @path_rules = PathRule.all
  end

  # GET /path_rules/1
  def show
  end

  # GET /path_rules/new
  def new
    @path_rule = PathRule.new
  end

  # GET /path_rules/1/edit
  def edit
  end

  # POST /path_rules
  def create
    @path_rule = PathRule.new(path_rule_params)

    if @path_rule.save
      redirect_to @path_rule, notice: 'Path rule was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /path_rules/1
  def update
    if @path_rule.update(path_rule_params)
      redirect_to @path_rule, notice: 'Path rule was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /path_rules/1
  def destroy
    @path_rule.destroy
    redirect_to path_rules_url, notice: 'Path rule was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_path_rule
      @path_rule = PathRule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def path_rule_params
      params.require(:path_rule).permit(:host_rule_id, :path_pattern, :excluded, :title_css_path, :content_css_paths, :ord)
    end
end
