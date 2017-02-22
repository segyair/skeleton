class CreateGreeters < ActiveRecord::Migration
  def self.up
    create_table :greeters do |t|
      t.string :name
      t.timestamps null: true
    end
  end

  def self.down
    drop_table :greeters
  end
end