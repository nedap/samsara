module Samsara::Model
  extend ActiveSupport::Concern

  included do
    def self.is_audited?
      @is_audited || false
    end

    def self.is_audited
      @is_audited = true

      has_many :auditing_revisions, class_name: Samsara.revision_class_name, as: :subject

      after_create  :audit_create
      after_update  :audit_update,  if: :saved_changes?
      after_destroy :audit_destroy
    end
  end

  def audit_create
    create_audit :create
  end

  def audit_update
    create_audit :update
  end

  def audit_destroy
    create_audit :destroy
  end

  def create_audit(action)
    return unless Samsara.active?
    Samsara.revision_class.new do |a|
      a.action  = action
      a.subject = self
      a.context = Samsara.current_context
      a.modified_attributes = self.attributes
      a.original_attributes = self.saved_changes.transform_values(&:first)
    end.save
  end
end
