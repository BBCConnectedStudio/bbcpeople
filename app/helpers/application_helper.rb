module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end


  def popularity_score(max, score)
    max = 1 if max < 1
    ((score.to_f / max.to_f) * 100).to_i
  end
end
