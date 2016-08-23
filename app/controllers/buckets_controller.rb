class BucketsController < ApplicationController

  private

  helper_method :bucket
  def bucket
    @bucket ||= Bucket.find(params[:id])
  end
end
