class CreateSkipContentRules < ActiveRecord::Migration
  def change
    create_table :skip_content_rules do |t|

      t.timestamps null: false
    end
  end
end
