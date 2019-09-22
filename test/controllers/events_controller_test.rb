require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { card_no: @event.card_no, cluster: @event.cluster, company_name: @event.company_name, company_system_name: @event.company_system_name, creation_date: @event.creation_date, csm_name: @event.csm_name, end_date: @event.end_date, event_name: @event.event_name, event_system_name: @event.event_system_name, event_type: @event.event_type, g_cal: @event.g_cal, link: @event.link, plugin_deployment: @event.plugin_deployment, plugin_name: @event.plugin_name, purge_date: @event.purge_date, start_date: @event.start_date } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { card_no: @event.card_no, cluster: @event.cluster, company_name: @event.company_name, company_system_name: @event.company_system_name, creation_date: @event.creation_date, csm_name: @event.csm_name, end_date: @event.end_date, event_name: @event.event_name, event_system_name: @event.event_system_name, event_type: @event.event_type, g_cal: @event.g_cal, link: @event.link, plugin_deployment: @event.plugin_deployment, plugin_name: @event.plugin_name, purge_date: @event.purge_date, start_date: @event.start_date } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
