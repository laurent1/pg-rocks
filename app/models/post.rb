class Post < ActiveRecord::Base

  def self.search_title(query)
    conditions = <<-EOS
      to_tsvector('english', title) @@ plainto_tsquery('english', ?)
    EOS

    where(conditions, query)
  end

  def self.search_title_and_body(query)
    conditions = <<-EOS
      to_tsvector('english',
        coalesce(title, '') || ' ' || coalesce(body, '')
      ) @@ to_tsquery('english', ?)
    EOS

    where(conditions, query)
  end


end
