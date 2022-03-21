class AddColumnsToEmailSanitizers < ActiveRecord::Migration[7.0]
  def change
    add_column :email_sanitizers, :project_name, :string
  end
end
