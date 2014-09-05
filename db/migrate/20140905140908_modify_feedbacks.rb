class ModifyFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :user_id, :integer
    add_column :feedbacks, :summary, :string

    change_column :feedbacks, :comment, :text

    add_index  :feedbacks, :user_id

  end
end
