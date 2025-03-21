class CreateGroupJoinRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :group_join_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.timestamps
    end
  end
end
