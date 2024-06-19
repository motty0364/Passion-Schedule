class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one_attached :task_image

  enum progress: { incomplete: 0, to_do: 1, complete: 2, standby: 3 }
  validates :title, presence: true, length: { maximum: 50 }
  
  has_many :child_relationships, dependent: :destroy, class_name: "TaskRelationship", foreign_key: "parent_task_id"
  has_many :parent_relationships, dependent: :destroy, class_name: "TaskRelationship", foreign_key: "child_task_id"
  has_many :child_tasks, through: :child_relationships, source: :child_task
  has_many :parent_tasks, through: :parent_relationships, source: :parent_task
end
