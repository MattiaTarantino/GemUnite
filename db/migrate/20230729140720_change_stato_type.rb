class ChangeStatoType < ActiveRecord::Migration[7.0]
  def change
    change_column(:projects, :stato, :string)

  end
end
