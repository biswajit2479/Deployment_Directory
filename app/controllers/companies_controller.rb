class CompaniesController < ApplicationController
  require 'csv'
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index

    company_scope = Company.includes(:deployments,:plugins,:cluster)
    company_scope = company_scope.cluster(params[:cluster_id]) if params[:cluster_id]
    company_scope = company_scope.where(cluster_id: params[:cluster]) if params[:cluster]
    company_scope = company_scope.search(params[:search]) if params[:search]
    company_scope = company_scope.order("companies.name ASC")
    company_scope = company_scope.all.paginate(page: params[:page], per_page: 13) if params[:skip_pagination] != "true"
    @companies = company_scope

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def show
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params.except(:deployment_id,:plugin_name))
    @company.deployments << Deployment.where(id: company_params[:deployment_id])
    @company.last_updated_by = current_user.name
    plugin_names.each do |name|
      @company.plugins << @company.plugins.where(name: name).first_or_initialize
    end
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params.except(:deployment_id,:plugin_name))
        @company.deployments << Deployment.where(id: company_params[:deployment_id])
        @company.last_updated_by = current_user.name
        plugins = []
        plugin_names.each do |name|
          plugins << @company.plugins.where(name: name).first_or_initialize
        end
        @company.plugins = plugins
        @company.save!

        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def plugin_names
    company_params[:plugin_name].reject(&:blank?)
  end

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :system_name, :cluster_id,:csm_info_id, plugin_name:[], deployment_id: [])
    end
end
