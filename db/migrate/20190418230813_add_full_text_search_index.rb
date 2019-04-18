class AddFullTextSearchIndex < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      create index on tweets using gin(to_tsvector('english', text));
    SQL
  end
end
