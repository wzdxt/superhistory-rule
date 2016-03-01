class SkipContentRulesController < ApplicationController
  before_action :set_skip_content_rule, only: [:show, :edit, :update, :destroy]

  # GET /skip_content_rules
  def index
    @skip_content_rules = SkipContentRule.all
  end

  # GET /skip_content_rules/1
  def show
  end

  # GET /skip_content_rules/new
  def new
    @skip_content_rule = SkipContentRule.new
  end

  # GET /skip_content_rules/1/edit
  def edit
  end

  # POST /skip_content_rules
  def create
    @skip_content_rule = SkipContentRule.new(skip_content_rule_params)

    if @skip_content_rule.save
      # redirect_to @skip_content_rule, notice: 'Skip content rule was successfully created.'
      redirect_to request.referer
    else
      render :new
    end
  end

  # PATCH/PUT /skip_content_rules/1
  def update
    if @skip_content_rule.update(skip_content_rule_params)
      redirect_to @skip_content_rule, notice: 'Skip content rule was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /skip_content_rules/1
  def destroy
    @skip_content_rule.destroy
    redirect_to skip_content_rules_url, notice: 'Skip content rule was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skip_content_rule
      @skip_content_rule = SkipContentRule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skip_content_rule_params
      params.require(:skip_content_rule).permit!
    end
end
