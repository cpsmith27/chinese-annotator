import React, { Component } from "react";
import PropTypes from "prop-types";

class VocabStore extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    let combinations = Object.values(this.state);

    let items = [];
    combinations.map(c => c.map(item => items.push(item)));
    let uniqueItems = Array.from(new Set(items));

    let divs = [];
    uniqueItems.map((ui, i) => divs.push(<div key={i}>{ui}</div>));

    return <div className="ca-vocab-store">{divs}</div>;
  }
}

VocabStore.propTypes = {};

export default VocabStore;
