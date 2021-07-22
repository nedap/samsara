require 'active_support/concern'

module Samsara::ContextConcern
  extend ActiveSupport::Concern

  included do
    attr_accessor :revisions, :event_attributes, :event_type, :environment_name, :application_name
  end

  def event_class
    event_type.constantize
  end

  def event
    @event ||= event_class.new(event_attributes)
  end

  def event=(event)
    self.event_type       = event.class.name
    self.event_attributes = event.attributes
  end

end
