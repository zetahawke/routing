import React from "react"
class Map extends React.Component {
  static self;
  constructor(props) {
    super(props);
    self = this;
    self.routes = [];

    self.loadRoutes = function (coords, map) {
      coords.forEach(function (route) {
        let path = new google.maps.Polyline({
          path: route,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 2
        });
        self.routes.push(path);
        path.setMap(map);
      })
    };

    self.initMap = function (coords) {
      self.map = new google.maps.Map(document.getElementById('map'), {
        zoom: 9,
        center: { lat: -33.445, lng: -70.669 },
      });

      self.loadRoutes(coords, self.map);
    };

    self.clearRoutes = function () {
      self.routes = [];
    };
  }

  componentDidMount() {

    self.initMap(self.props.coords);
    // App.map = App.cable.subscriptions.create("MapChannel", {
    //   connected: function () {
    //     self.initMap(self.props.coords);
    //   },

    //   disconnected: function () {
    //   },

    //   received: function (data) {
    //     // self.clearRoutes();
    //     // self.loadRoutes(data.coords, self.map)
    //   },

    //   speak: function () {
    //     // this.perform('refresh_info');
    //   }
    // });

    // setInterval(function () {
    //   App.map.speak();
    // }, 10000)
  }

  render() {
    return (
      <div className='google-map'>
        <div id='map'></div>
      </div>
    );
  }
}

export default Map
