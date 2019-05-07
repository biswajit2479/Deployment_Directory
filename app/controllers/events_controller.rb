class EventsController < ApplicationController
  require 'csv'
  before_action :set_event, only: [:show, :edit, :update, :destroy, :purge, :unpurge]

  def index
    event_scope = Event.all.includes(:plugins,company: :cluster)
    event_scope = event_scope.search(params[:search]) if params[:search]

      if params[:purge_passive]
        event_scope.purge_passive params[:date_search]
        flash[:notice] = "All Passive Events were successfully Purged."
      end
    event_scope = event_scope.passive(params[:date_search]) if params[:date_search].present?
    event_scope = event_scope.cluster_events(params[:cluster_id]) if params[:cluster_id]
    event_scope = event_scope.cluster_events(params[:cluster]) if params[:cluster]
    event_scope = event_scope.order("events.purge_status")
    event_scope = event_scope.order("events.updated_at DESC")
    event_scope = event_scope.all.paginate(page: params[:page], per_page: 30) if params[:skip_pagination] != "true"
    @events = event_scope

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params.except(:plugin_name,:purge_date, :creation_date, :link ,:purge_status))
    plugin_names.each do |name|
      @event.plugins << @event.plugins.where(name: name).first_or_initialize
    end
    #@event.plugins << Plugin.where(id: event_params[:plugin_id])
    @event.creation_date = DateTime.now.strftime('%d/%m/%Y')
    @event.last_updated_by = current_user.name
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def filter
    options =
    case filter_params[:filter_action]
    when "show_passive"
      {date_search: filter_params[:date_search]}
    when "purge_passive"
      {purge_passive: true, date_search: filter_params[:date_search]}
    when "export"
      {date_search: filter_params[:date_search], format: "xls",skip_pagination: true}
    end
  redirect_to events_url(options)
  end

  def update
    respond_to do |format|
      if @event.update(event_params.except(:plugin_name, :creation_date,:purge_date, :link ))
        plugins = []
        plugin_names.each do |name|
          plugins << @event.plugins.where(name: name).first_or_initialize
        end
        @event.plugins = plugins
        @event.last_updated_by = current_user.name
        @event.save!
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def purge
    @event.purge
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully Purged.' }
      format.json { head :no_content }
    end
  end

  def unpurge
    @event.unpurge
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully UnPurged.' }
      format.json { head :no_content }
    end
  end

  def purge_passive_event
    event = Event.includes(:plugins)
    event.purge_passive params[:date_search]
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'All Passive Events were successfully Purged.' }
      format.json { head :no_content }
    end
  end


  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def plugin_names
    event_params[:plugin_name].reject(&:blank?)
  end

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:company_id, :event_name, :event_system_name, 
        :event_type_id, :start_date, :end_date, :creation_date, :purge_date, :card_no,
         :link, :status_id, :purge_status, plugin_name: [])
    end

    def filter_params
      params.require(:filter).permit(:date_search, :filter_action)
    end
end
