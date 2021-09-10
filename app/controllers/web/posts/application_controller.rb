# frozen_string_literal: true

class Web::Posts::ApplicationController < Web::ApplicationController
  before_action :authenticate_user!

  helper_method :resource_post

  def resource_post
    @resource_post ||= Post.find(params[:post_id])
  end
end
