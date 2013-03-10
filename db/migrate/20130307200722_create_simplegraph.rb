class CreateSimplegraph < ActiveRecord::Migration
  def up
    create_table :graphs do |t|
      t.integer  :date
      t.float    :value
    end
  end

  def down
    drop_table :graphs
  end
end
