class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :acronym
      t.string :capital

      t.timestamps null: false
    end
  end
end
