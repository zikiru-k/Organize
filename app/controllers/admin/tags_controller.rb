class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
end
