module Samsara::Model
  extend ActiveSupport::Concern

  included do
    def self.is_audited?
      @is_audited || false
    end

    def self.is_audited
      @is_audited = true

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
    Samsara.revision_class.new(
        action: action,
        subject: self,
        context: Samsara.current_context,
        modified_attributes: self.attributes,
        original_attributes: self.saved_changes.transform_values(&:first)
    ).save
  end
end
