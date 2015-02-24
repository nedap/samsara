module Samsara::Controller
  extend ActiveSupport::Concern

  included do
    before_filter :set_samsara_context
    after_filter  :unset_samsara_context
  end

  def set_samsara_context
    return unless Samsara.active?
    Samsara.current_context = build_samsara_context
  end

  def unset_samsara_context
    Samsara.current_context = nil
  end

  def build_samsara_context
    Samsara.context_class.new.tap do |c|
      c.event = build_samsara_http_request
      c.application_name = application_name_for_samsara
      c.environment_name = environment_name_for_samsara
    end
  end

  def build_samsara_http_request
    Samsara::HttpRequest.new(request_attributes_for_samsara)
  end

  def request_attributes_for_samsara
    {
      url:       request.filtered_path,
      params:    request.filtered_parameters,
      method:    request.method
    }
  end

  def environment_name_for_samsara
    Rails.env
  end

  def application_name_for_samsara
    Rails.application.class.parent.name
  end
end
