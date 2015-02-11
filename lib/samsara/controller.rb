module Samsara::Controller
  extend ActiveSupport::Concern

  included do
    before_filter :set_auditing_context
    after_filter  :unset_auditing_context
  end

  def set_auditing_context
    return unless Samsara.active?
    Samsara.current_context = build_auditing_context
  end

  def unset_auditing_context
    Samsara.current_context = nil
  end

  def build_auditing_context
    Samsara.context_class.new.tap do |c|
      c.event = build_auditing_request
      c.application_name = application_name_for_auditing
      c.environment_name = environment_name_for_auditing
    end
  end

  def build_auditing_request
    Samsara::HttpRequest.new.tap do |r|
      r.user        = current_user
      r.real_user   = current_real_user
      r.url         = request.filtered_path
      r.params      = request.filtered_parameters
      r.method      = request.method
    end
  end

  def environment_name_for_auditing
    Rails.env
  end

  def application_name_for_auditing
    Rails.application.class.parent.name
  end
end
