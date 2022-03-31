class CreateEmployeeStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_statuses do |t|
      t.string :intime
      t.string :outtime
      t.string :task1
      t.string :task2
      t.string :week_goals
      t.string :productive_hour
      t.string :email_date
      t.string :sent_by
      t.string :email_body
      t.string :email_subject

      t.timestamps
    end
  end
end
