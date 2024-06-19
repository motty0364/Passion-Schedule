class CreateTaskRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :task_relationships do |t|
      t.references :parent_task, null: false, foreign_key: { to_table: :tasks }
      t.references :child_task, null: false, foreign_key: { to_table: :tasks }

      t.timestamps
      t.index [:parent_task_id, :child_task_id], unique: true
    end
  end
end
