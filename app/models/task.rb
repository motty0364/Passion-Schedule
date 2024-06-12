class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one_attached :task_image

  enum progress: { incomplete: 0, to_do: 1, complete: 2, standby: 3 }
end
