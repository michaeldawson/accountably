class Account extends React.Component {
  constructor() {
    super();

    this.handleChange = () => {
      console.log('update!');
      AccountActions.updateAccount(this.properties());
    }

    this.handleSlider = (value) => {
      AccountActions.updateAccount({ id: 1, amount: parseInt(value) })
    }
  }

  properties() {
    return {
      id: this._id.value,
      name: this._name.value,
      amount: this._amount.value,
    }
  }

  render() {
    return (
      <div className="row">
        <div className="col-xs-6 col-sm-4">
          <div className="form-group string optional budget_accounts_name">
            <input
              type='hidden'
              ref={(c) => this._id = c}
              value={this.props.id}
            />
            <input
              ref={(c) => this._name = c}
              className="form-control string optional"
              placeholder="Name"
              type="text"
              value={this.props.name}
              onChange={this.handleChange}
            />
          </div>
        </div>
        <div className="col-xs-6 col-sm-2">
          <div className="form-group string required budget_accounts_amount">
            <input
              ref={(c) => this._amount = c}
              className="form-control string required sliderInput"
              placeholder="Amount"
              type="text"
              value= {this.props.amount}
              onChange={this.handleChange}
            />
          </div>
        </div>
        <div className="col-xs-12 col-sm-6">
          <Slider
            value={this.props.amount}
            onChange={this.handleSlider}
          />
        </div>
        <div className="col-xs-2">
          <a className="remove_fields" href="#">
            <i className="ion-ios-close-outline"></i>
          </a>
        </div>
      </div>
    );
  }
}
