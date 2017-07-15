class AddDescriptionToMyThreads < ActiveRecord::Migration[5.0]
  def change
    add_column :my_threads, :description, :text
  end
end
