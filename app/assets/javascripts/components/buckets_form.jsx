class BucketsForm extends React.Component {
  constructor() {
    super();

    this.state = BucketsStore.getState();
    this.handleStoreChange = (state) => { this.setState(state); }
    this.handleNew = () => { BucketActions.buildNew(); }
  }

  componentDidMount() {
    BucketsStore.listen(this.handleStoreChange);
    BucketActions.fetch();
  }

  componentWillUnmount() {
    BucketsStore.unlisten(this.handleStoreChange);
  }

  render() {
    const { target } = this.props;

    return (
      <form role="form" className="form-horizontal form-bordered">
        <div className="form-body">
          {
            this.state.buckets.map(function(bucket, index) {
              return <Bucket
                {...bucket}
                key={index}
                max={target}
              ></Bucket>
            })
          }
          <a
            ref={(c) => this._newButton = c}
            className='btn btn-default'
            onClick={this.handleNew}
          >Add new</a>
        </div>
      </form>
    )
  }
}
