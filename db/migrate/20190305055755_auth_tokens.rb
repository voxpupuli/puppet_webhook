class AuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
