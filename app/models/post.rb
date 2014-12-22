class Post < ActiveRecord::Base

  # for simple text. one field
  def self.search_title(query)
    conditions = <<-EOS
      to_tsvector('english', title) @@ plainto_tsquery('english', ?)
    EOS

    where(conditions, query)
  end

  # for multiple fiels. Query allows operators. recompile tsvector every time.
  def self.search_title_and_body(query)
    conditions = <<-EOS
      to_tsvector('english',
        coalesce(title, '') || ' ' || coalesce(body, '')
      ) @@ to_tsquery('english', ?)
    EOS

    where(conditions, query)
  end

  # Use tsvector saved in a column. Uses db trigger. More efficient solution
  # because of pre-compile tsvector and db process for updating posts.
  def self.search_tsvector(query)
    conditions = <<-EOS
      search_vector @@ to_tsquery('english', ?)
    EOS

    where(conditions, query)
  end


end
