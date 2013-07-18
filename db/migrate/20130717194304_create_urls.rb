class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :long, null: false
      t.string :short
      t.integer :click_count, default: 0
      t.belongs_to :user

      t.timestamps
    end
  end
end

