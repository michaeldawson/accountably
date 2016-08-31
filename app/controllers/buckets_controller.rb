class BucketsController < ApplicationController
  def update
    if bucket.update(bucket_attributes)
      flash[:notice] = 'Bucket was updated'
      redirect_to bucket
    else
      flash[:error] = "Sorry, that didn't work"
      render 'edit'
    end
  end

  private

  helper_method :bucket
  def bucket
    @bucket ||= Bucket.find(params[:id])
  end

  def bucket_attributes
    params.require(:bucket).permit(:name, :amount, :balance)
  end

  helper_method :transaction
  def transaction
    @transaction ||= Transaction.new(effective_date: Time.current.to_date)
  end
end
