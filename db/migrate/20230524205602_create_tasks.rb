class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title,        null: false, default: ""
      t.string :description,  null: false, default: ""
      t.integer :status,      null: false, default: 0
      t.integer :priority,    null: false, default: 0
      t.belongs_to :user,     null: false

      t.timestamps            null: false
    end
  end
end
