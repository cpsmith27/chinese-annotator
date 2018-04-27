import React, { Component } from "react";
import PropTypes from "prop-types";

class TextItem extends Component {
  render() {
    return <span className="ca-entry">{JSON.stringify(this.props)}</span>;
  }
}

TextItem.propTypes = {
  value: PropTypes.string
};

export default TextItem;
