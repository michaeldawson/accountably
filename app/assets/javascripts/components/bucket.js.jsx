class Bucket extends React.Component {
  constructor() {
    super();

    this.handleChange = () => {
      BucketActions.update(this.properties());
      if(this.props.id) {
        BucketActions.updateInAPI(this.properties());
      }
    }

    this.handleSave = () => {
      BucketActions.create(this.props.key, this.properties());
    }

    this.handleSliderSlide = (value) => {
      BucketActions.update({ id: this._id.value, amount: parseInt(value) })
    }

    this.handleSliderChange = (value) => {
      BucketActions.updateInAPI({ id: this._id.value, amount: parseInt(value) })
    }
  }

  properties() {
    return {
      id: this._id.value,
      name: this._name.value,
      amount: this._amount.value,
    }
  }

  action() {
    if(this.props.id) {
      return (
        <a className="remove_fields" href="#">
          <i className="ion-ios-close-outline"></i>
        </a>
      )
    } else {
      return(
        <a className='btn btn-default' onClick={this.handleSave}>Save</a>
      )
    }
  }

  render() {
    return (
      <div className="row">
        <div className="col-xs-6 col-sm-4">
          <div className="form-group string optional budget_buckets_name">
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
          <div className="form-group string required budget_buckets_amount">
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
        <div className="col-xs-12 col-sm-4">
          <Slider
            value={this.props.amount}
            onSlide={this.handleSliderSlide}
            onChange={this.handleSliderChange}
            max={parseInt($('.budget_target input').val().replace(/[^0-9.]+/g, ''))}
          />
        </div>
        <div className="col-xs-2">
          {this.action()}
        </div>
      </div>
    );
  }
}
