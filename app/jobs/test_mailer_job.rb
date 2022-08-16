# frozen_string_literal: true

class TestMailerJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    User.find_each do |user|
      TestNotifierMailer.test_sender(user).deliver_now
    end
  end
end
