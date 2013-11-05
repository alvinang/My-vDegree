class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :user, index: true
      t.string :name
      t.string :url
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
