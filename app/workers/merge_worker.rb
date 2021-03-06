# frozen_string_literal: true

class MergeWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'pull'

  def perform(from_account_id, into_account_id)
    FeedManager.instance.merge_into_home(Account.find(from_account_id), Account.find(into_account_id))
  rescue ActiveRecord::RecordNotFound
    true
  end
end
