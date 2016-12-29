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

    updateAccountInAPI(accountProps) {
      var id = accountProps.id;
      delete accountProps.id;

      $.ajax({
        url: '/api/int/accounts/' + id,
        method: 'PUT',
        data: { account: accountProps }
      });
    }

    updateAccount(accountProps) {
      return accountProps;
    }
  }

  this.AccountActions = alt.createActions(AccountActions);
})();
