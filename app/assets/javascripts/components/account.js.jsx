class Account extends React.Component {
  constructor() {
    super();
    this.handleChange = () => {
      // this.props.onChange(this._name.value);
    }
  }

  render() {
    return (
      <input
       ref={(c) => this._name = c}
       onChange={this.handleChange}
       type="text"
       value={this.props.name} />
    );
  }
}
