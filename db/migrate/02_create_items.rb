class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.text :description
      t.integer :stage

      t.timestamps
    end
  end
end
