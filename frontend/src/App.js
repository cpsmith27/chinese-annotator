import React, { Component } from "react";
import Document from "./components/Document.js";
import data from "./data.json";

class App extends Component {
  render() {
    return <Document paragraphs={data.text_blocks} />;
  }
}

export default App;
