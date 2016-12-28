(() => {
  class AccountActions {
    fetchAccountsSuccess(accounts) {
      return accounts;
    }

    fetchAccountsFailed(error) {
      return [];
    }

    fetchAccounts() {
      return (dispatch) => {
        dispatch();
        AccountsStore.fetch()
      }
    }

    updateAccount(accountProps) {
      var props = $.extend(true, {}, accountProps);

      var id = props.id;
      delete props.id;

      $.ajax({
        url: '/api/int/accounts/' + id,
        method: 'PUT',
        data: { account: props }
      });

      return accountProps;
    }
  }

  this.AccountActions = alt.createActions(AccountActions);
})();
