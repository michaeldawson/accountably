class AccountsForm extends React.Component {
  constructor() {
    super();

    this.state = AccountsStore.getState();
    this.handleStoreChange = (state) => { this.setState(state); }
    this.handleNew = () => { AccountActions.buildNew(); }
  }

  componentDidMount() {
    AccountsStore.listen(this.handleStoreChange);
    AccountActions.fetch();
  }

  componentWillUnmount() {
    AccountsStore.unlisten(this.handleStoreChange);
  }

  render() {
    return (<div>
      {
        this.state.accounts.map(function(account, index) {
          return <Account
            {...account}
            key={index}
            onChange={this.handleViewChange}
          ></Account>
        })
      }
      <a
        ref={(c) => this._newButton = c}
        className='btn btn-default'
        onClick={this.handleNew}
      >Add new</a>
    </div>)
  }
}
