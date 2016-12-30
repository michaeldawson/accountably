var BucketsSource = {
  fetch: {
    remote(state) {
      return new Promise(function (resolve, reject) {
        $.get('/api/int/buckets', function(data){
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
