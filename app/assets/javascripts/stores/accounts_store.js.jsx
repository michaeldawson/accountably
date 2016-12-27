(() => {
  class AccountsStore {
    constructor() {
      this.accounts = []

      this.bindListeners({
        handleUpdateAccounts: AccountActions.UPDATE_ACCOUNTS,
      });

      this.registerAsync(AccountsSource)
    }

    handleUpdateAccounts(accounts) {
      this.accounts = accounts;
    }
  }

  this.AccountsStore = alt.createStore(AccountsStore, 'AccountsStore');
})();
