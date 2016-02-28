class CreateHostRules < ActiveRecord::Migration
  def change
    create_table :host_rules do |t|
      t.string :host
      t.integer :port
      t.boolean :include_sub
      t.boolean :disable

      t.timestamps null: false
    end
  end
end
