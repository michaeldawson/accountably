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

    this.handleDelete = () => {
      BucketActions.delete(this._id.value);
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
        <a onClick={this.handleDelete}>
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
    const { id, name, amount, max } = this.props;

    return (
      <div className="form-group">
        <div className="col-md-4">
          <input
            type='hidden'
            ref={(c) => this._id = c}
            value={id}
          />
          <input
            ref={(c) => this._name = c}
            className="form-control"
            placeholder="Name"
            type="text"
            value={name}
            onChange={this.handleChange}
          />
        </div>
        <div className="col-md-2">
          <input
            ref={(c) => this._amount = c}
            className="form-control"
            placeholder="Amount"
            type="text"
            value= {amount}
            onChange={this.handleChange}
          />
        </div>
        <div className="col-sm-4">
          <Slider
            value={amount}
            onSlide={this.handleSliderSlide}
            onChange={this.handleSliderChange}
            max={max}
          />
        </div>
        <div className="col-xs-2">
          {this.action()}
        </div>
      </div>
    );
  }
}
