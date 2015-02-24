class CreateTestTables < ActiveRecord::Migration
  def change

    create_table :samsara_revisions do |t|
      t.string      :action
      t.integer     :subject_id
      t.string      :subject_type
      t.text        :modified_attributes
      t.text        :original_attributes
      t.references  :context, index: true
      t.timestamps
    end

    create_table :samsara_contexts do |t|
      t.string  :event_type
      t.text    :event_attributes
      t.string  :environment_name
      t.string  :application_name
      t.timestamps
    end

    create_table :celebrities do |t|
      t.string  :first_name
      t.string  :last_name
      t.integer :gender
      t.date    :birth_date
    end

  end
end
