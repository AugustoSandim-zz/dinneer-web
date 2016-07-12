class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.boolean :capital, default: false
      t.references :state, index: true

      t.timestamps null: false
    end
    add_foreign_key :cities, :states
  end
end
