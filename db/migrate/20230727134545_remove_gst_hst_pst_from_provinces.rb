class RemoveGstHstPstFromProvinces < ActiveRecord::Migration[7.0]
  def change
    remove_column :provinces, :gst, :decimal
    remove_column :provinces, :hst, :decimal
    remove_column :provinces, :pst, :decimal
  end
end
