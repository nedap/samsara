module Samsara::ContextConcern
  extend ActiveSupport::Concern

  # t.string  :event_type
  # t.text    :event_attributes
  # t.string  :environment_name
  # t.string  :application_name
  # t.timestamps

  included do
    has_many :revisions, class_name: Samsara.revision_class_name

    serialize :event_attributes, Samsara::Serializer
  end

  def event_class
    ::Object.const_get(event_type)
  end

  def event
    @event ||= event_class.new(event_attributes)
  end

  def event=(event)
    self.event_type       = event.class.name
    self.event_attributes = event.attributes
  end

end
