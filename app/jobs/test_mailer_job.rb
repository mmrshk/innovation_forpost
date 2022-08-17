# frozen_string_literal: true

class TestMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      TestNotifierMailer.with(user: user).test_sender.deliver_now
    end
  end
end
