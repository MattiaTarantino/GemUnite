class ChangeTypeProject < ActiveRecord::Migration[7.0]
  def change
    change_column :projects, :dimensione, :integer
  end
end

