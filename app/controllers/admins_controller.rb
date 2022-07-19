# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :authenticate_user!
end
