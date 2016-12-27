var AccountsSource = {
  fetch: {
    remote(state) {
      return new Promise(function (resolve, reject) {
        $.get('/api/int/accounts', function(data){
          resolve(data.data);
        });
      });
    },

    success: AccountActions.updateAccounts, // (required)
    error: AccountActions.updateAccountsFailed, // (required)
    shouldFetch(state) {
      return true
    }
  },

};
