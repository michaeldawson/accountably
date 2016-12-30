(() => {
  class AccountsStore {
    constructor() {
      this.accounts = []

      this.bindListeners({
        handleNew: AccountActions.BUILD_NEW,
        handleCreate: AccountActions.CREATE,
        handleUpdate: AccountActions.UPDATE,
        handleFetch: AccountActions.FETCH_SUCCESS,
      });

      this.registerAsync(AccountsSource)
    }

    handleNew() {
      this.accounts.push({ id: '', name: '', amount: 0 })
    }

    handleCreate(key, id) {
      this.accounts = this.accounts.map(function(account) {
        if(account.key == key) {
          return account
        } else {
          return { id: id, ...account.attributes };
        }
      });
    }

    handleFetch(accounts) {
      debugger;
      this.accounts = accounts;
    }

    handleUpdate(accountProps) {
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
