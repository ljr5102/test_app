class CreateGame < ActiveRecord::Migration[5.2]
  def change
    start_array = [
      ['','','','','','','','',''],
      ['','','','','','','','',''],
      ['','','','','','','','',''],
      ['','','','','','','','',''],
      ['','','','','','','','',''],
      ['','','','','','','','',''],
      ['','','','','','','','',''],
      ['','','','','','','','',''],
      ['','','','','','','','',''],
    ]
    create_table :games do |t|
      t.text :board, null: false, array: true, default: start_array
      t.text :turn, null: false, default: "X"
      t.timestamps
    end
  end
end
