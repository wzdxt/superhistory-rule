class CreatePathRules < ActiveRecord::Migration
  def change
    create_table :path_rules do |t|
      t.integer :host_rule_id
      t.string :path_pattern
      t.boolean :excluded, :default => false
      t.text :title_css_path
      t.text :content_css_paths, :default => '[]'
      t.integer :ord, :limit => 1

      t.timestamps null: false
    end
  end
end
