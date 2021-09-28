class CreateFieldNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :field_notes do |t|
      t.string :long_text
      t.string :user
      t.datetime :date
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
