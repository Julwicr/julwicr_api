class CreateLongestWords < ActiveRecord::Migration[7.0]
  def change
    create_table :longest_words do |t|
      t.string :answer
      t.string :result
      t.string :player
      t.string :grid
      t.integer :time
      t.integer :score

      t.timestamps
    end
  end
end
