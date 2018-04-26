import React, { Component } from "react";
import data from "./data.json";

class App extends Component {
  getSpans() {
    console.log(data);
    let l = data.text_blocks.length;
    let segs = data.text_blocks;
    let spans = [];
    for (var i = 0; i < l; i++) {
      spans.push(<span key={i}>{segs[i][0]}</span>);
    }

    return spans;
  }

  render() {
    return (
      <div className="App">
        <div>{this.getSpans()}</div>
      </div>
    );
  }
}

export default App;
