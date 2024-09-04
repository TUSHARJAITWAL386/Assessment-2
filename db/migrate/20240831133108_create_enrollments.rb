class CreateEnrollments < ActiveRecord::Migration[7.1]
  def change
    create_table :enrollments do |t|
      t.references :student, foreign_key: { to_table: :users }
      t.references :course, null: false, foreign_key: true
      t.string :grade

      t.timestamps
    end
  end
end
