# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/test_notifier
class TestNotifierPreview < ActionMailer::Preview
  def test_notifier
    TestNotifierMailer.with(user: User.first).test_sender
  end
end
