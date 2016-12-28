class Slider extends React.Component {
  constructor() {
    super();

    this.id = Math.random().toString(36).replace(/[^a-z]+/g, '');

    this.handleChange = (value) => {
      this.props.onChange(value);
    }
  }

  value() {
    return this.props.value.replace(/[^0-9]+/g, '');
  }

  componentDidMount() {
    console.log('init slider');
    var slider = document.getElementById(this.id),
        sliderChange = this.handleChange,
        value = this.value();

    noUiSlider.create(slider, {
    	start: [value],
    	range: { 'min': 0, 'max': 100 }
    });

    slider.noUiSlider.on('change', function(){
    	sliderChange(this.get());
    });
  }

  render() {
    return (
      <div id={this.id}></div>
    )
  }
}
