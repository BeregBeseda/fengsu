class AddPageDefineAndEmToPages < ActiveRecord::Migration
  def change
    add_column :pages, :em,   :string
    add_column :pages, :page, :string
  end
end
