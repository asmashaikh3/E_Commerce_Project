class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :pst, precision: 5, scale: 2
      t.decimal :gst, precision: 5, scale: 2
      t.decimal :hst, precision: 5, scale: 2

      t.timestamps
    end
  end
end
