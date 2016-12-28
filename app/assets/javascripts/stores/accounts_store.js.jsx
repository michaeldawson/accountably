(() => {
  class AccountsStore {
    constructor() {
      this.accounts = []

      this.bindListeners({
        handleFetchAccounts: AccountActions.FETCH_ACCOUNTS_SUCCESS,
        handleUpdateAccount: AccountActions.UPDATE_ACCOUNT,
      });

      this.registerAsync(AccountsSource)
    }

    handleFetchAccounts(accounts) {
      this.accounts = accounts;
    }

    handleUpdateAccount(accountProps) {
      this.accounts = this.accounts.map(function(account) {
        if(account.id == accountProps.id) {
          return { account, ...accountProps };
        } else {
          return { id: account.id, ...account.attributes };
        }
      });
    }
  }

  this.AccountsStore = alt.createStore(AccountsStore, 'AccountsStore');
})();
