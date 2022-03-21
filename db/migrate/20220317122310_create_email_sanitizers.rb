class CreateEmailSanitizers < ActiveRecord::Migration[7.0]
  def change
    create_table :email_sanitizers do |t|
      t.string :intime
      t.string :outtime
      t.string :tasks
      t.string :productive_hour
      t.string :date
      t.string :sent_by

      t.timestamps
    end
  end
end
