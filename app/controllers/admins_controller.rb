class AdminsController < ApplicationController
  def index
    @vendors = Vendor.all
  end
end
