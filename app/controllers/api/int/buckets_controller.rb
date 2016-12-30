module API
  module Int
    class BucketsController < BaseController
      def index
        render json: buckets
      end

      def create
        if bucket.save
          render json: bucket
        else
          render json: bucket.errors
        end
      end

      def update
        bucket.update(bucket_params)
        head :ok
      end

      private

      def buckets
        return Bucket.none unless current_budget
        @buckets ||= current_budget.buckets
      end

      def bucket
        @bucket ||= current_budget.buckets.find(params[:id]) if params.key?(:id)
        @bucket ||= current_budget.buckets.new(bucket_params)
      end

      def bucket_params
        params.require(:bucket).permit(:id, :name, :amount) if params.key?(:bucket)
      end
    end
  end
end
