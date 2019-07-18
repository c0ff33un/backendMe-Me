class RecalculateScoresJob < ApplicationJob
  queue_as :default

  def perform(meme)
    meme.re_score!
  end
end
