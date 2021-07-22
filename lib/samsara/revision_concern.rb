require 'active_support/concern'

module Samsara::RevisionConcern
  extend ActiveSupport::Concern

  included do
    attr_accessor :action, :subject, :context, :modified_attributes, :original_attributes

    def initialize(subject:, action:, context:, modified_attributes:, original_attributes:)
      self.subject = subject
      self.action = action
      self.context = context
      self.modified_attributes = modified_attributes
      self.original_attributes = original_attributes
    end

    def subject_id
      subject.id
    end

    def subject_type
      subject.class
    end
  end
end
