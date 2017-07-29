class AddDetailsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :detail, :text
  end
end
