require "samsara/version"

module Samsara

  def self.table_name_prefix
    'samsara_'
  end

  def self.active?
    active != :disabled
  end

  def self.active
    @@auditing_active ||= :disabled
  end

  def self.active=(active)
    @@auditing_active = active
  end

  def self.enable!
    @@auditing_active = :enabled
  end

  def self.disable!
    @@auditing_active = :disabled
  end

  def self.current_context=(val)
    Thread.current[:samsara_context] = val
  end

  def self.current_context
    Thread.current[:samsara_context]
  end

  def self.revision_class_name
    @@revision_class_name ||= "Samsara::Revision"
  end

  def self.revision_class_name=(name)
    @@revision_class_name = name
  end

  def self.revision_class
    revision_class_name.constantize
  end

  def self.context_class_name
    @@context_class_name ||= "Samsara::Context"
  end

  def self.context_class_name=(name)
    @@context_class_name = name
  end

  def self.context_class
    context_class_name.constantize
  end

  def self.request_class_name
    @@request_class_name ||= "Samsara::HttpRequest"
  end

  def self.request_class_name=(name)
    @@request_class_name = name
  end

  def self.request_class
    request_class_name.constantize
  end

  def self.configure(&block)
    yield self
  end

end

require "samsara/http_request"
require "samsara/revision_concern"
require "samsara/revision"
require "samsara/context_concern"
require "samsara/context"
require "samsara/model"
require "samsara/controller"
require "samsara/railtie" if defined?(Rails)
