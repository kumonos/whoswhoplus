class RelationsController < ApplicationController
  before_action :requires_login
  before_action :check_common_friends
end
