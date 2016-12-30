(() => {
  class AccountActions {
    buildNew() {
      return true;
    }

    fetch() {
      return (dispatch) => { AccountsStore.fetch() }
    }

    fetchSuccess(accounts) {
      return accounts;
    }

    fetchFailed(error) {
      return [];
    }

    create(key, accountProps) {
      return (dispatch) => {
        $.ajax({
          url: '/api/int/accounts/',
          method: 'POST',
          data: { account: accountProps }
        }).then(function(data){
          dispatch(key, data.id);
        })
      }
    }

    updateInAPI(accountProps) {
      var id = accountProps.id;
      delete accountProps.id;

      $.ajax({
        url: '/api/int/accounts/' + id,
        method: 'PUT',
        data: { account: accountProps }
      });
    }

    update(accountProps) { return accountProps; }
  }

  this.AccountActions = alt.createActions(AccountActions);
})();
