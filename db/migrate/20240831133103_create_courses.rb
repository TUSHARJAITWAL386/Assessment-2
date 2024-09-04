class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.references :teacher, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
