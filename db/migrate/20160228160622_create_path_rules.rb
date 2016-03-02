class CreatePathRules < ActiveRecord::Migration
  def change
    create_table :path_rules do |t|
      t.integer :host_rule_id
      t.string :path_pattern
      t.boolean :excluded, :default => false
      t.string :title_css_path, :limit => 10000
      t.string :content_css_paths, :limit => 10000, :default => '[]'
      t.integer :ord, :limit => 1

      t.timestamps null: false
    end
  end
end
