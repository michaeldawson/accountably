(() => {
  class BucketsStore {
    constructor() {
      this.buckets = []

      this.bindListeners({
        handleNew: BucketActions.BUILD_NEW,
        handleCreate: BucketActions.CREATE,
        handleUpdate: BucketActions.UPDATE,
        handleFetch: BucketActions.FETCH_SUCCESS,
      });

      this.registerAsync(BucketsSource)
    }

    handleNew() {
      this.buckets.push({ id: '', name: '', amount: 0 })
    }

    handleCreate(key, id) {
      this.buckets = this.buckets.map(function(bucket) {
        if(bucket.key == key) {
          return bucket
        } else {
          return { id: id, ...bucket.attributes };
        }
      });
    }

    handleFetch(buckets) {
      this.buckets = buckets;
    }

    handleUpdate(bucketProps) {
      this.buckets = this.buckets.map(function(bucket) {
        if(bucket.id == bucketProps.id) {
          return { bucket, ...bucketProps };
        } else {
          return { id: bucket.id, ...bucket.attributes };
        }
      });
    }
  }

  this.BucketsStore = alt.createStore(BucketsStore, 'BucketsStore');
})();
