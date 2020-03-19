class Addcolumninstructiontococktail < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :instructions, :string
  end
end
