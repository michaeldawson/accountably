(() => {
  class BucketActions {
    buildNew() {
      return true;
    }

    fetch() {
      return (dispatch) => { BucketsStore.fetch() }
    }

    fetchSuccess(buckets) {
      return buckets;
    }

    fetchFailed(error) {
      return [];
    }

    create(key, bucketProps) {
      return (dispatch) => {
        $.ajax({
          url: '/api/int/buckets/',
          method: 'POST',
          data: { bucket: bucketProps }
        }).then(function(data){
          dispatch(key, data.id);
        })
      }
    }

    updateInAPI(bucketProps) {
      var id = bucketProps.id;
      delete bucketProps.id;

      $.ajax({
        url: '/api/int/buckets/' + id,
        method: 'PUT',
        data: { bucket: bucketProps }
      });
    }

    update(bucketProps) { return bucketProps; }

    delete(id) {
      return (dispatch) => {
        $.ajax({
          url: '/api/int/buckets/' + id,
          method: 'DELETE',
        }).then(function(data){
          dispatch(data.id);
        });
      }
    }
  }

  this.BucketActions = alt.createActions(BucketActions);
})();
