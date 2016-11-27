function initPieCharts() {
  function colorFromPercentage(percentage) {
    var neg = percentage < 0 ? -1 : 1;

    var red = Math.sqrt(Math.abs(percentage)) / 10 * 255 * neg;
    var green = - red;
    var blue = 150 - Math.abs(red) / 2;

    return '#' + rgbToHex(rgbRange(red), rgbRange(green), rgbRange(blue));
  }

  function rgbRange(number) {
    number = number < 0 ? 0 : number;
    number = number > 255 ? 255 : number;
    return number;
  }

  function rgbToHex(R,G,B) {
    return toHex(R)+toHex(G)+toHex(B);
  }

  function toHex(n) {
    n = parseInt(n, 10);
    if (isNaN(n)) return "00";
    n = Math.max(0,Math.min(n, 255));
    return "0123456789ABCDEF".charAt((n - n % 16) / 16) + "0123456789ABCDEF".charAt(n % 16);
  }

  $('.easy-pie-chart .number').each(function() {
    var $this = $(this);

    $this.easyPieChart({
      animate: 1000,
      size: 70,
      lineWidth: 3,
      barColor: $this.data('color') || colorFromPercentage
    });
  });

  var accountsPieChart = $('#accountsPieChart');

  $.plot(accountsPieChart, accountsPieChart.data('chart'), {
    series: {
      pie: {
        show: true,
        combine: {
          color: '#999',
          threshold: 0.02
        }
      },
    },
    legend: {
      show: false
    },
    grid: {
      hoverable: true,
      clickable: true
    }
  });
}
