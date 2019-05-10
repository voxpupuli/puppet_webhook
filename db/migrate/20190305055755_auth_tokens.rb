class AuthTokens < ActiveRecord::Migration
  def up
    create_table :auth_tokens do |t|
      t.string :token
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def down
    drop_table :auth_tokens
  end
end
