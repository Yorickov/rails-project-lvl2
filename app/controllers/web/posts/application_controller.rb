# frozen_string_literal: true

class Web::Posts::ApplicationController < Web::ApplicationController
  before_action :authenticate_user!

  def post
    @post ||= Post.find(params[:post_id])
  end
end
