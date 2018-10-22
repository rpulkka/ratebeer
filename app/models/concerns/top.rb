module Top
  extend ActiveSupport::Concern

  def top(parameter)
    sorted_by_rating_in_desc_order = all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating_in_desc_order.take(parameter)
  end
end
