class CreateUserSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :user_sessions do |t|
      t.string :email
      t.string :password_digest
      t.boolean :is_superadmin

      t.timestamps
    end
  end
end
