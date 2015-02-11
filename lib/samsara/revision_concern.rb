module Samsara::RevisionConcern
  extend ActiveSupport::Concern

  #  t.string     :action
  #  t.integer    :subject_id
  #  t.string     :subject_type
  #  t.text       :modified_attributes
  #  t.text       :original_attributes
  #  t.references :context
  #  t.timestamps

  included do
    belongs_to :subject, polymorphic: true
    belongs_to :context, class_name: Samsara.context_class_name

    default_scope{ order(:created_at) }

    serialize :modified_attributes, Samsara::Serializer
    serialize :original_attributes, Samsara::Serializer
  end

  def attribute_changes
    original_attributes.each_with_object({}) do |(attribute, value), changes|
      changes[attribute] = [value, modified_attributes[attribute]]
    end
  end

end
