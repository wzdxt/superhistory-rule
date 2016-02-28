class CreateContentRules < ActiveRecord::Migration
  def change
    create_table :content_rules do |t|
      t.text :title_css_path
      t.text :content_css_paths, :default => '[]'

      t.timestamps null: false
    end
  end
end
