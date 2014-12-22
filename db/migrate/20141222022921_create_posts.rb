class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.column :search_vector, 'tsvector'
      t.boolean :published, :null => false

      t.timestamps null: false
    end

    execute <<-EOS
      CREATE INDEX posts_search_idx ON posts USING gin(search_vector)
    EOS

    execute <<-EOS
      CREATE UNIQUE INDEX posts_title_idx ON posts (lower(title))
      WHERE published
    EOS

    execute <<-EOS
      DROP TRIGGER IF EXISTS posts_vector_update ON posts
    EOS

    execute <<-EOS
      CREATE TRIGGER posts_vector_update BEFORE INSERT OR UPDATE
      ON posts
      FOR EACH ROW EXECUTE PROCEDURE
        tsvector_update_trigger(search_vector, 'pg_catalog.english',
          title, body);
    EOS
  end

  def self.down
    drop_table :posts
  end
end
