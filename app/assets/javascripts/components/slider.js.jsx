class Slider extends React.Component {
  constructor() {
    super();

    this.id = Math.random().toString(36).replace(/[^a-z]+/g, '');

    this.handleChange = (value) => {
      this.props.onChange(value);
    }

    this.handleSlide = (value) => {
      this.props.onSlide(value);
    }
  }

  value() {
    return this.props.value.toString().replace(/[^0-9.]+/g, '');
  }

  componentDidMount() {
    var slider = document.getElementById(this.id),
        sliderSlide = this.handleSlide,
        sliderChange = this.handleChange,
        value = this.value();

    noUiSlider.create(slider, {
    	start: [value],
    	range: { 'min': 0, 'max': this.props.max }
    });

    slider.noUiSlider.on('slide', function(){
    	sliderSlide(this.get());
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
