class FixPictureAttachment < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :picture, :attachment
  end
end
