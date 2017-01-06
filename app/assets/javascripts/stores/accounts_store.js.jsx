(() => {
  const BucketsSource = {
    fetch: {
      remote(state) {
        return new Promise((resolve, reject) => {
          $.get('/api/int/buckets', data => {
            resolve(data);
          });
        });
      },

      success: BucketActions.fetchSuccess,
      error: BucketActions.fetchFailed,

      shouldFetch(state) {
        return true
      }
    },
  };

  class BucketsStore {
    constructor() {
      this.buckets = []

      this.bindListeners({
        handleNew: BucketActions.BUILD_NEW,
        handleCreate: BucketActions.CREATE,
        handleUpdate: BucketActions.UPDATE,
        handleFetch: BucketActions.FETCH_SUCCESS,
        handleDelete: BucketActions.DELETE,
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

    handleDelete(id) {
      this.buckets = this.buckets.filter(function(bucket) {
        return bucket.id != id
      });
    }
  }

  this.BucketsStore = alt.createStore(BucketsStore, 'BucketsStore');
})();
