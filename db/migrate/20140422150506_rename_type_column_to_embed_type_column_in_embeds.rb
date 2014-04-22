class RenameTypeColumnToEmbedTypeColumnInEmbeds < ActiveRecord::Migration
  def change
    rename_column :embeds, :type, :embed_type
  end
  
end
