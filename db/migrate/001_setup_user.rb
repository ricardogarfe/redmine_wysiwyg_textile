class SetupUser < ActiveRecord::Migration
  
  def self.up

    add_column :user_preferences, :default_editor, :string
    
  end
  
  def self.down
    remove_column :user_preferences, :default_editor
  end
  
end