class Post < ActiveRecord::Base

  def self.search(query)
    conditions = <<-EOS
      to_tsvector('english', title) @@ plainto_tsquery('english', ?)
    EOS

    where(conditions, query)
  end



end
