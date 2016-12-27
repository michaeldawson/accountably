(() => {
  class AccountActions {
    updateAccounts(accounts) {
      return accounts.map(function(account){
        return { id: account.id, ...account.attributes };
      })
    }

    updateAccountsFailed(error) {
      return [];
    }

    fetchAccounts() {
      return (dispatch) => {
        dispatch();
        AccountsStore.fetch()
      }
    }
  }

  this.AccountActions = alt.createActions(AccountActions);
})();
