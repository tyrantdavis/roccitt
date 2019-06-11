class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.boolean :public, default: true

      t.timestamps
    end
  end
end
