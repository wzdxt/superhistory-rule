class CreatePathRules < ActiveRecord::Migration
  def change
    create_table :path_rules do |t|
      t.integer :host_url_id
      t.string :path_pattern

      t.timestamps null: false
    end
  end
end
