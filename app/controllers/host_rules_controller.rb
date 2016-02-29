class HostRulesController < ApplicationController
  before_action :set_host_rule, only: [:show, :edit, :update, :destroy]

  # GET /host_rules
  def index
    @host_rules = HostRule.all
  end

  # GET /host_rules/1
  def show
  end

  # GET /host_rules/new
  def new
    @host_rule = HostRule.new
  end

  # GET /host_rules/1/edit
  def edit
  end

  # POST /host_rules
  def create
    @host_rule = HostRule.new(host_rule_params)

    if @host_rule.save
      redirect_to @host_rule, notice: 'Host rule was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /host_rules/1
  def update
    if @host_rule.update(host_rule_params)
      redirect_to @host_rule, notice: 'Host rule was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /host_rules/1
  def destroy
    @host_rule.destroy
    redirect_to host_rules_url, notice: 'Host rule was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host_rule
      @host_rule = HostRule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def host_rule_params
      params.require(:host_rule).permit(:host, :port, :include_sub, :excluded, :ord)
    end
end
