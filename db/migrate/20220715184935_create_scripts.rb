class CreateScripts < ActiveRecord::Migration[7.0]
  def change
    create_table :scripts do |t|
      t.text :code
      t.string :slug, null: false
      t.string :title, null: false
      t.string :description
      t.integer :run_count, default: 0, null: false
      t.bigint :user_id
      t.integer :visibility, default: 0

      t.timestamps
    end

    add_index :scripts, :slug, unique: true
  end
end
