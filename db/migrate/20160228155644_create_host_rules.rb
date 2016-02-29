class CreateHostRules < ActiveRecord::Migration
  def change
    create_table :host_rules do |t|
      t.string :host
      t.integer :port, :default => nil
      t.boolean :include_sub, :default => false
      t.boolean :excluded, :default => false
      t.integer :ord, :limit => 1

      t.timestamps null: false
    end
  end
end
