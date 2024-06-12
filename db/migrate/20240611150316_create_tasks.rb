class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.integer :progress, null: false, default: 0
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
