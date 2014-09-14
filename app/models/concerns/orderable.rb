module Orderable
  extend ActiveSupport::Concern

  module ClassMethods
    def custom_order order

      case order
      when 'newest'         then by = { created_at: :desc }
      when 'oldest'         then by = { created_at: :asc }
      when 'relevance'      then by = { hotness: :desc }
      when 'most-comments'  then by = { comments_count: :desc }
      when 'least-comments' then by = { comments_count: :asc }
      else raise 'Unknown order param passed.'
      end

      order(by)
    end
  end

end
