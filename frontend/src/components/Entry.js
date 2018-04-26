import React, { Component } from "react";
import PropTypes from "prop-types";

class Entry extends Component {
  render() {
    return <span className="ca-entry">{this.props.value}</span>;
  }
}

Entry.propTypes = {
  value: PropTypes.string
};

export default Entry;
