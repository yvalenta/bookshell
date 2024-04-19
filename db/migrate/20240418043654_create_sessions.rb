class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.references :user_session, null: false, foreign_key: true
      t.string :key

      t.timestamps
    end
  end
end
