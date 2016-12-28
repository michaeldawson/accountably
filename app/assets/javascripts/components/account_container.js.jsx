class AccountContainer extends React.Component {
  constructor() {
    super();

    this.state = AccountsStore.getState();

    this.handleStoreChange = (state) => {
      this.setState(state);
    }
  }

  componentDidMount() {
    AccountsStore.listen(this.handleStoreChange);
    AccountActions.fetchAccounts();
  }

  componentWillUnmount() {
    AccountsStore.unlisten(this.handleStoreChange);
  }

  render() {
    return <div>
      {
        this.state.accounts.map(function(account, index) {
          return <Account
            {...account}
            key={index}
            onChange={this.handleViewChange}
          ></Account>
        })
      }
    </div>
  }
}
