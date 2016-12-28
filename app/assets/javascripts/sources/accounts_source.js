var AccountsSource = {
  fetch: {
    remote(state) {
      return new Promise(function (resolve, reject) {
        $.get('/api/int/accounts', function(data){
          resolve(data);
        });
      });
    },

    success: AccountActions.fetchAccountsSuccess,
    error: AccountActions.fetchAccountsFailed,

    shouldFetch(state) {
      return true
    }
  },
};
